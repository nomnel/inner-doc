require 'spec_helper'

describe User do
  it "is valid with an username, email, password and password_confirmation" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without an username" do
    expect(build(:user, username: nil)).to have(1).errors_on(:username)
  end

  it "is invalid without an email address" do
    expect(build(:user, email: nil)).to have(1).errors_on(:email)
  end

  it "is invalid without a password" do
    expect(build(:user, password: nil)).to have(1).errors_on(:password)
  end

  it "is invalid with a duplicate username" do
    user1 = create(:user)
    user2 = build(:user, username: user1.username)
    expect(user2).to have(1).errors_on(:username)
  end

  it "is invalid with a duplicate email address" do
    user1 = create(:user)
    user2 = build(:user, email: user1.email)
    expect(user2).to have(1).errors_on(:email)
  end
end
