class Permission < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :subject_class, presence: true
  validates :action, presence: true

  def resource
    subject_class.constantize.find(subject_id)
  end

  def resource_id
    resource.id
  end
end
