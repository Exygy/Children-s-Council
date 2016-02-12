# == Schema Information
#
# Table name: found_options
#
#  id   :integer          not null, primary key
#  name :text             not null
#

class FoundOption < ActiveRecord::Base
  validates :name, presence: true
  has_many :parents
end