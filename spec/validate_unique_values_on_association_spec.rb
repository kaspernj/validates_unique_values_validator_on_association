require "rails_helper"

describe ValidatesUniqueValuesOnAssociation do
  let(:element) { create :element }

  it "validates unique values on association" do
    element.options.build(value: "Donald Duck")
    element.options.build(value: "Donald Duck")

    expect(element).not_to be_valid
    expect(element.errors.full_messages).to eq ["Options hadn't unique values: Donald Duck"]
  end

  it "works with other locales" do
    I18n.with_locale(:da) do
      element.options.build(value: "Donald Duck")
      element.options.build(value: "Donald Duck")

      expect(element).not_to be_valid
      expect(element.errors.full_messages).to eq ["Options havde ikke unikke værdier: Donald Duck"]
    end
  end
end
