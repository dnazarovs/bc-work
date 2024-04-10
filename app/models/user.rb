class User < ApplicationRecord
  NAME_REGEX = /\A[a-zA-Z]+\z/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts
  validates :name, presence: true, format: { with: NAME_REGEX }
  validates :last_name, presence: true, format: { with: NAME_REGEX }
  validates :age, presence: true, numericality: { only_integer: true, greater_or_equal_than: 18 }
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX, multiline: true }
end
