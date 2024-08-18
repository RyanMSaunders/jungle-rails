require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with a password and password_confirmation' do
      user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).to be_valid
    end

    it 'is invalid when password and password_confirmation do not match' do
      user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'different_password',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is invalid without an email' do
      user = User.new(
        email: nil,
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is invalid without a first name' do
      user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: nil,
        last_name: 'User'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is invalid without a last name' do
      user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: nil
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'validates uniqueness of email (case insensitive)' do
      User.create!(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      user = User.new(
        email: 'TEST@TEST.COM',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'validates password minimum length' do
      user = User.new(
        email: 'test@test.com',
        password: 'short',
        password_confirmation: 'short',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create!(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
    end

    it 'authenticates a user with correct credentials' do
      user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(user).to eq(@user)
    end

    it 'does not authenticate a user with incorrect credentials' do
      user = User.authenticate_with_credentials('test@test.com', 'wrong_password')
      expect(user).to be_nil
    end

    it 'authenticates a user with email containing spaces' do
      user = User.authenticate_with_credentials('  test@test.com  ', 'password')
      expect(user).to eq(@user)
    end

    it 'authenticates a user with email in different case' do
      user = User.authenticate_with_credentials('TeSt@TeSt.CoM', 'password')
      expect(user).to eq(@user)
    end
  end
  end