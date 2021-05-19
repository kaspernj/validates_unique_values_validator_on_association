require_relative "validates_unique_values_on_association/version"
require_relative "validates_unique_values_on_association/railtie"
require_relative "unique_values_on_association_validator"

module ValidatesUniqueValuesOnAssociation
  def self.locale_files
    files = []

    available_locales = []
    available_locales += I18n.available_locales if I18n.available_locales
    available_locales += Rails.application.config.i18n.available_locales if Rails.application.config.i18n.available_locales
    available_locales.uniq!

    available_locales.each do |locale|
      path = "#{File.realpath("#{__dir__}/../config/locales")}/#{locale}.yml"
      files << File.realpath(path) if File.exist?(path)
    end

    files
  end
end
