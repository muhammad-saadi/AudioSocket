class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :password , format: { with: /^(?=.*[A-Z])(?=.*[$@$!%*?&])/ , :multiline => true , message: "Must contain atleast One Special-Character, One Upper-Case, and Minimum-Length of 8"}
end
