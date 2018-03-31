class Comment <ApplicationRecord

  belongs_to :chef

  belongs_to :recipe

  default_scope -> { order(updated_at: :desc) }

  validates :chef_id, presence: true

  validates :description, presence: true, length: { minimum: 4, maximum: 140 }

  validates :recipe_id, presence: true

end
