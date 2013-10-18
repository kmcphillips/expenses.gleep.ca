class LoginToken < ActiveRecord::Base
  belongs_to :household
  belongs_to :user

  validates :token, presence: true
  validates :household_id, presence: true
  validates :user_id, presence: true
  validate :user_part_of_household

  before_validation :set_token

  def set_token
    self.token = SecureRandom.hex if self.token.blank?
  end

  def login_link

  end

  private

  def user_part_of_household
    errors.add(:user, "must be part of the household") if !user || !household || household != user.household
  end

end
