require "yaml"

CONFIG_FILE = File.expand_path("../tensorbuzz.yml", __dir__)
CONFIG_FILE_NAMES = ["peak_flow.yml", "tensorbuzz.yml"].freeze
ALLOWED_SKIPS = [".github/**", ".gitignore", ".rubocop.yml", "config/locales/**", "MIT-LICENSE", "README.md"].freeze
SHARED_PATH_PREFIXES = ["Appraisals", "Gemfile", "Rakefile", "bin", "gemfiles", "lib", "spec"].freeze

describe "tensorbuzz.yml" do
  let(:builds) { YAML.load_file(CONFIG_FILE).fetch("builds") }
  let(:paths_lists) { builds.transform_values { |build| Array(build["paths"]) } }
  let(:all_paths) { paths_lists.values }
  let(:negated_rules) do
    all_paths.flat_map { |paths| paths.select { |pattern| pattern.is_a?(String) && pattern.start_with?("!") } }
  end

  it "declares a non-empty paths list on every build" do
    builds_without_paths = paths_lists.filter_map { |name, paths| name if paths.empty? }

    expect(builds_without_paths).to be_empty
  end

  it "keeps every path rule a quoted string" do
    non_string_rules = all_paths.flat_map do |paths|
      paths.reject { |pattern| pattern.is_a?(String) && !pattern.empty? }
    end

    expect(non_string_rules).to be_empty
  end

  it "parses every negation written in the file" do
    written_negations = File.readlines(CONFIG_FILE).count { |line| line.match?(/^\s*- "!/) }

    expect(negated_rules.length).to eq written_negations
  end

  it "starts every paths list with a positive rule so negations are evaluated last" do
    unanchored_builds = paths_lists.filter_map { |name, paths| name if paths.first.to_s.start_with?("!") }

    expect(unanchored_builds).to be_empty
  end

  it "skips only paths that no build consumes" do
    skipped_paths = negated_rules.map { |pattern| pattern.delete_prefix("!") }

    expect(skipped_paths - ALLOWED_SKIPS).to be_empty
  end

  it "never filters the config file that declares the filter" do
    filtered_config_files = all_paths.flat_map { |paths| paths & CONFIG_FILE_NAMES }

    expect(filtered_config_files).to be_empty
  end

  it "keeps shared tooling, root configuration and lockfiles unfiltered" do
    negated_shared_paths = all_paths.flat_map do |paths|
      paths.select do |pattern|
        SHARED_PATH_PREFIXES.any? { |prefix| pattern.to_s.delete_prefix("!").start_with?(prefix) }
      end
    end

    expect(negated_shared_paths).to be_empty
  end
end
