class Favorite < ApplicationRecord
  validates :job_id, presence: true, uniqueness: { scope: :job_id }
  validates :email, presence: true

  scope :from_user_email, ->(email) { where(email: email) }
end
