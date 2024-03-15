require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value("sumit123@gmail.com").for(:email) }
    it { should_not allow_value("sumit").for(:email) }

    it { should validate_presence_of(:password) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should allow_value('John').for(:first_name) }
    it { should_not allow_value('123').for(:first_name) }
    it { should allow_value('Doe').for(:last_name) }
    it { should_not allow_value('456').for(:last_name) }

  end

  describe 'associations' do
    it { should belong_to(:role) }
    it { should have_one(:student_placement) }
    it { should have_many(:testimonials) }
    it { should have_many(:user_applications) }
  end

  describe 'has_secure_password' do
    it { should have_secure_password }
  end


end
