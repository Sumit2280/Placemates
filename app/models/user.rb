class User < ApplicationRecord
  has_secure_password

  belongs_to :role
  has_one :student_placement
  has_many :testimonials
  has_many :user_applications

  validates :email, presence: true, uniqueness: true, format: {with: /\A\w+[@][a-z]+[.]\w+\z/, message: 'Must be a valid email'}
  validates :password, presence: true
  validates :first_name, :last_name, presence: true, format: {with: /\A[a-zA-Z]+\z/, message: 'Only characters are allowed'}
  # validates :batch, :branch, presence: true

 end
