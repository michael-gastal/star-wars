require 'rails_helper'

RSpec.describe Link, type: :model do
  let (:user1) do
    User.create!(email: "michael@email.com", password: "123456")
  end

  let (:people_link) do
    Link.create!(url: "https://swapi.dev/api/people/")
  end

  let (:skywalker_link) do
    Link.create!(url: "https://swapi.dev/api/people/?search=skywalker")
  end

  let(:valid_attributes) do
    {
      url: "https://swapi.dev/api/people/?search=skywalker"
    }
  end

  it "has a url" do
    link = Link.new(url: "https://swapi.dev/api/people/?search=skywalker")
    expect(link.url).to eq("https://swapi.dev/api/people/?search=skywalker")
  end

  it "url starts with https://swapi.dev/api/" do
    link1 = Link.new(url: "https://swapi.dev/api/people/?search=skywalker")
    expect(link1.url).to match(/https:\/\/swapi.dev\/api\/.*/)
  end

  it "belongs to a user" do
    link = Link.new(user: user1)
    expect(link.user).to eq(user1)
  end
end
