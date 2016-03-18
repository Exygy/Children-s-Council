# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class Language < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :providers
end
