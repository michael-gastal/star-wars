require 'open-uri'
require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    base_url = "https://swapi.dev/api/"

    @research = params[:films] if params[:films].present?
    @research = params[:people] if params[:people].present?
    @research = params[:planets] if params[:planets].present?
    @research = params[:species] if params[:species].present?
    @research = params[:starships] if params[:starships].present?
    @research = params[:vehicles] if params[:vehicles].present?

    @url = "#{base_url}/films/?search=#{@research}" if params[:films].present?
    @url = "#{base_url}/people/?search=#{@research}" if params[:people].present?
    @url = "#{base_url}/planets/?search=#{@research}" if params[:planets].present?
    @url = "#{base_url}/species/?search=#{@research}" if params[:species].present?
    @url = "#{base_url}/starships/?search=#{@research}" if params[:starships].present?
    @url = "#{base_url}/vehicles/?search=#{@research}" if params[:vehicles].present?

    @result = JSON.parse(open(@url).read) unless @url.nil?

  end
end
