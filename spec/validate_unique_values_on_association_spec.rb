require "rails_helper"

describe ValidatesUniqueValuesOnAssociation do
  let(:element) { create :element }

  it "validates unique values on association" do
    option1 = element.options.build(value: "Donald Duck")
    option2 = element.options.build(value: "Donald Duck")

    expect(element).to be_invalid
    expect(element.errors.full_messages).to eq ["Options hadn't unique values: Donald Duck"]
  end

  it "works with other locales" do
    I18n.with_locale(:da) do
      option1 = element.options.build(value: "Donald Duck")
      option2 = element.options.build(value: "Donald Duck")

      expect(element).to be_invalid
      expect(element.errors.full_messages).to eq ["Options havde ikke unikke værdier: Donald Duck"]
    end
  end
end
