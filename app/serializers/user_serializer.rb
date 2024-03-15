class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name
  has_many :user_applications
  has_one :student_placement
end
