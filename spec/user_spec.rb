require_relative '../config/environment'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with password and password_confirmation fields' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: nil,
        password_confirmation: nil
      )
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    

    it 'should have matching password and password_confirmation' do
      user = User.new(password: 'password', password_confirmation: 'different_password')
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'requires password and password_confirmation fields' do
      user = User.new
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should have unique emails (case-insensitive)' do
      existing_user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password')
      user = User.new(email: 'TEST@TEST.com', password: 'password', password_confirmation: 'password')
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'requires email, first name, and last name fields' do
      user = User.new
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Email can't be blank")
      expect(user.errors.full_messages).to include("First name can't be blank")
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns user instance if successfully authenticated' do
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to have_attributes(
        first_name: user.first_name,
        last_name: user.last_name,
        email: 'test@example.com'
      )
    end

    it 'ignores case sensitivity in email' do
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to have_attributes(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com'
      )
    end

  it 'returns user instance if successfully authenticated' do
  user = User.create(
    first_name: 'John',
    last_name: 'Doe',
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
  authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
  expect(authenticated_user).to have_attributes(
    first_name: user.first_name,
    last_name: user.last_name,
    email: 'test@example.com'
  )
end
    

    it 'ignores case sensitivity in email' do
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to have_attributes(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com'
      )
    end
  end
end