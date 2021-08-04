class Link < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, format: { with: /\Ahttps:\/\/swapi.dev\/api\/.*\z/ }
end
