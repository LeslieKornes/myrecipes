class Recipe < ApplicationRecord

  belongs_to :chef

  default_scope -> { order(updated_at: :desc) }

  has_many :comments, dependent: :destroy

  has_many :ingredients, through: :recipe_ingredients

  has_many :recipe_ingredients

  validates :chef_id, presence: true

  validates :description, presence: true, length: { minimum: 5, maximum: 500 }

  validates :name, presence: true

end
