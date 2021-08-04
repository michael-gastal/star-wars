class Link < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, format: { with: /https:\/\/swapi.dev\/api\/.*/ }
end
