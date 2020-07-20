class Company < ApplicationRecord
  has_rich_text :description
  # could have included ActiveRecord::Validator as well. but since only two validations are there ,
  # thought of handling them in model only.
  validates :email,format: { with: /@getmainstreet.com\z/, message: "Invalid email. Must end with @getmainstreet.com"}, unless: ->{email.blank?}
  validate :is_us_zip_code?

  def is_us_zip_code?
    self.errors.add(:zip_code, "Must be a valid US zip code") if ZipCodes.identify(self.zip_code).nil?
  end

  def zip_code_details
    # intially loading zipcode will be slow as it tries loading the full yaml.
    # subsequent hits will be fast once zip code yaml is loaded into memory
    details = ZipCodes.identify(self.zip_code)
    "#{details[:city]}, #{details[:state_name]}"
  end
end
