class User < ApplicationRecord
  include DeviseInvitable::Inviter
  has_one :artist_profile
  attribute :email_content
  devise :database_authenticatable, :confirmable, :invitable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:artist, :manager]

  validate :password_validation

  def password_validation
    rules = {
      'must contain at least one uppercase letter'  => /[A-Z]+/,
      'must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add( :password, message ) unless password.match( regex )
    end
  end
end
