class Provider < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :city
  belongs_to :mail_city, class_name: 'City', foreign_key: :mail_city_id
end
