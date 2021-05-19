require "rails_helper"

describe ValidatesUniqueValuesOnAssociation do
  let(:element) { create :element }

  it "validates unique values on association" do
    option1 = element.options.build(value: "Donald Duck")
    option2 = element.options.build(value: "Donald Duck")

    expect(element).to be_invalid
    exepct(element.errors.full_messages).to eq ["asd"]
  end
end
