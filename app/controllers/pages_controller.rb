require 'open-uri'
require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  CATEGORIES = ["Films", "Personnages", "Planètes", "Espèces", "Vaisseaux", "Véhicules"]

  def home
    base_url = "https://swapi.dev/api/"

    @category = find_category

    research = params["name"] if params[:name].present?

    @url = "#{base_url}/#{@category}" if params[:category].present?
    @url = "#{base_url}/#{@category}/?search=#{research}" if params[:category].present? && params[:name].present?

    @result = JSON.parse(open(@url).read) unless @url.nil?

    if @category != "films" && params[:category].present?
      @pages = []
      until @result["next"].nil?
        @pages << @result
        @url = @result["next"]
        @result = JSON.parse(open(@url).read)
      end
      @pages << @result
    else
      @pages = [@result]
    end
  end

  private

  def find_category
    category = "films" if params[:category] == "Films"
    category = "people" if params[:category] == "Personnages"
    category = "planets" if params[:category] == "Planètes"
    category = "species" if params[:category] == "Espèces"
    category = "starships" if params[:category] == "Vaisseaux"
    category = "vehicles" if params[:category] == "Véhicules"

    return category
  end
end
