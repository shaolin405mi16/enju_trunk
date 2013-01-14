class UserStatus < ActiveRecord::Base
  attr_accessible :display_name, :name, :position

  validates_uniqueness_of :name
  validates_presence_of :name, :display_name

  default_scope :order => 'position'
  paginates_per 10
end
