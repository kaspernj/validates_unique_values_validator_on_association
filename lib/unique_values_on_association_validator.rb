class UniqueValuesOnAssociationValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    association = object.association(attribute)
    target = association.target
    child_attribute_name = options.fetch(:attribute)

    return if target.blank?

    values = []
    duplicates = []

    target.each do |child|
      child_attribute_value = child[child_attribute_name]

      if values.include?(child_attribute_value)
        duplicates << child_attribute_value
        child.errors.add(child_attribute_name, options[:message] || :taken)
      end

      values << child_attribute_value
    end

    if duplicates.any?
      object.errors.add(attribute, :hadnt_unique_values, joined_duplicates: duplicates.join(", "), **options)
    end
  end
end