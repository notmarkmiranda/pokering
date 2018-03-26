class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :leagues
  has_many :permissions

  validates :email, presence: true, uniqueness: true

  def full_name
    first_name.blank? ? email :  "#{first_name} #{last_name}"
  end
end
