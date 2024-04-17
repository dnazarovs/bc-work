class User < ApplicationRecord
  NAME_REGEX = /\A[a-zA-Z]+\z/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts
  validates :name, presence: true
  validates :name, format: { with: NAME_REGEX, message: 'should include only symbols' }, if: -> { name.present? }
  validates :last_name, presence: true
  validates :last_name, format: { with: NAME_REGEX, message: 'should include only symbols' }, if: -> { last_name.present? }
  validates :age, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 17, lower_than: 100 }, if: -> { age.present? }
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX }, if: -> { email.present? }
end
