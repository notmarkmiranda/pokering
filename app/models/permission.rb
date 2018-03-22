class Permission < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :subject_class, presence: true
  validates :action, presence: true
end
