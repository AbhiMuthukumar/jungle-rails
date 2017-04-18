require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should validate true on matching password and password_confirmation" do
      @user = User.new({
        name:'ashwin',
        email: 'ashwin@gmail.com',
        password: 'ashwin',
        password_confirmation: 'ashwin'
        })
      @user.save
      expect(@user.id).to be_present
    end

    it "should return error as password and password_confirmation do not match" do
      @user = User.new({
        name:'thambi',
        email: 'thambi@gmail.com',
        password: 'thambi',
        password_confirmation: 'thambii'
        })
      @user.save
      expect(@user.errors.full_messages.include?("Password confirmation doesn't match Password")).to eq(true)
    end

    it "should fail on trying to register with already registered email" do
      @user = User.new({
        name:'thambi',
        email: 'thambi@gmail.com',
        password: 'thambi',
        password_confirmation: 'thambi'
        })
      @user.save

      @user = User.new({
        name:'thambi',
        email: 'THAMBI@gmail.com',
        password: 'thambi',
        password_confirmation: 'thambi'
        })
      @user.save
      expect(@user.errors.full_messages.include?("Email has already been taken")).to eq(true)
    end

    it "should throw error on blank name or email" do
      @user = User.new({
        email: 'thambi@gmail.com',
        password: 'thambi',
        password_confirmation: 'thambi'
        })
      @user.save
      expect(@user.errors.full_messages.include?("Name can't be blank")).to eq(true)
    end

    it "should throw error on password length less than 6 characters" do
      @user = User.new({
        name: 'thambi',
        email: 'thambi@gmail.com',
        password: 'th',
        password_confirmation: 'thambi'
        })
      @user.save
      expect(@user.errors.full_messages.include?("Password is too short (minimum is 6 characters)")).to eq(true)
    end

    it "should validate true if email has any spaces around it" do
      @user = User.new({
        name:'thambi',
        email: 'thambi@gmail.com',
        password: 'thambi',
        password_confirmation: 'thambi'
        })
      @user.save
      user = User.authenticate_with_credentials('   thambi@gmail.com   ','thambi')
        expect(user).to be_present
    end

    it "should validate true if email has any spaces around it" do
      @user = User.new({
        name:'thambi',
        email: 'thambi@gmail.com',
        password: 'thambi',
        password_confirmation: 'thambi'
        })
      @user.save
      user = User.authenticate_with_credentials('THAMBI@gmail.com','thambi')
        expect(user).to be_present
    end
  end

  describe ".authenticate_with_credentials" do
    @user = User.new({
        name:'thambi',
        email: 'thambi@gmail.com',
        password: 'thambi',
        password_confirmation: 'thambi'
        })
    @user.save
    it "should return true if the email and password authenticates true" do
      user = User.authenticate_with_credentials('thambi@gmail.com','thambi')
      expect(user).to be_present
    end
  end
end
