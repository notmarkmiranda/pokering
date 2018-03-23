class League < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :seasons
  delegate :permissions, to: :creator, prefix: true, allow_nil: false

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true

  after_create_commit :create_permission

  private

  def create_permission
    creator_permissions.create!(subject_id: self.id, subject_class: self.class.to_s, action: 'manage')
  end
end
