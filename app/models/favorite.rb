class Favorite < ApplicationRecord
  validates :job_id, presence: true
  validates :email, presence: true

  scope :from_user_email, ->(email) { where(email: email) }
end
