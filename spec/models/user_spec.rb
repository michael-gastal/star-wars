require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    {
      email: "michael@email.com",
      password: "123456"
    }
  end

  it "has an email and a password" do
    user = User.new(email: "michael@email.com", password: "123456")
    expect(user.email).to eq("michael@email.com")
    expect(user.password).to eq("123456")
  end

  it "email is unique" do
    User.create!(email: "michael@email.com", password: "123456")
    user = User.new(email: "michael@email.com")
    expect(user).not_to be_valid
  end

  it "email cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:email)
    user = User.new(attributes)
    expect(user).not_to be_valid
  end

  it "password cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:email)
    user = User.new(attributes)
    expect(user).not_to be_valid
  end

  it "password cannot be shorter than 6 characters" do
    user = User.new(email: "michael@email.com", password: "12345")
    expect(user).not_to be_valid
  end

  it "has many links" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:links)
    expect(user.links.count).to eq(0)
  end
end
