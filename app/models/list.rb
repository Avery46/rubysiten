class List < ApplicationRecord
    belongs_to :user
    has_many :list_categories
    has_many :categories, through: :list_categories
    validates :title, presence: true, length: { minimum: 6, maximum: 100 }
    validates :description, presence: true, length: { minimum: 10, maximum: 300 }
    validates :fulltext, presence: true, length: { minimum: 20, maximum: 1500 }
    
end
