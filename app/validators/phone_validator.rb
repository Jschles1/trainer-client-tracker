class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "provided is not a valid phone number") unless
      value =~ /\d{3}-\d{3}-\d{4}/
  end
end