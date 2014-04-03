class User < ActiveRecord::Base
  devise :token_authenticatable, :rememberable, :trackable, :omniauthable, :database_authenticatable, :validatable, omniauth_providers: [:google]
  # :recoverable, :confirmable, :lockable, :timeoutable, :database_authenticatable

  belongs_to :household

  validates :email, presence: true

  after_create :assign_default_household

  def authorized?
    !!AuthorizedEmail.where(email: email).first
  end

  def update_from_auth(auth)
    info = auth.try(:info)

    if info
      update_column(:name, info["name"]) if info["name"].present?
    end
  end

  def short_name
    name.split(" ").first if name.present?
  end

  private

  def assign_default_household
    update_attribute :household, AuthorizedEmail.where(email: email).last.try(:household) unless household
  end

  class << self

    def find_for_open_id(access_token, signed_in_resource=nil)
      email = access_token.info["email"]
      User.where(email: email).first || User.create(email: email, password: Devise.friendly_token[0,20])
    end

  end
end
