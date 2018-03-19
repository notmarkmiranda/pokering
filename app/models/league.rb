class League < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
