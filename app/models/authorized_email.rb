class AuthorizedEmail < ActiveRecord::Base
  belongs_to :household

  validates :email, presence: true, uniqueness: {scope: :household_id}

end
