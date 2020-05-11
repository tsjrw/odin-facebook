class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2}
end
