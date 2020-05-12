class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id


  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2}
end
