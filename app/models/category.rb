class Category < ApplicationRecord
       
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
  has_many :list_categories
  has_many :lists, through: :list_categories
end
