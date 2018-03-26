class Season < ApplicationRecord
  belongs_to :league

  validates :league_id, presence: true

  before_save :deactivate_other_seasons

	scope :in_order, -> { order(created_at: :asc) }

  def activate_button(context)
    send(context) ? 'times-circle' : 'check-circle'
  end

  def active_text
    active? ? 'Active' : 'Inactive'
  end

  def active_title
    active? ? 'Mark as Inactive' : 'Mark as Active'
  end

  def completed_text
    completed? ? 'Completed' : 'Incomplete'
  end

  def completed_title
    completed? ? 'Mark as Incomplete' : 'Mark as Complete'
  end

  private

  def deactivate_other_seasons
    if self.active? && (self.active_changed? || self.id.nil?)
      league.seasons.where.not(id: self).update_all(active: false)
    end
  end
end
