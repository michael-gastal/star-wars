require 'open-uri'
require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  CATEGORIES = ["Films", "Personnages", "Planètes", "Espèces", "Vaisseaux", "Véhicules"]

  def home
    @user = current_user

    base_url = "https://swapi.dev/api"

    @category = find_category

    research = params["name"] if params[:name].present?

    @url = "#{base_url}/#{@category}" if params[:category].present?
    @url = "#{base_url}/#{@category}/?search=#{research}" if params[:category].present? && params[:name].present?

    @result = JSON.parse(open(@url).read) unless @url.nil?

    @pages = multi_pages(@category, @result)

    link_save(@url) unless @url.nil?
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

  def multi_pages(category, result)
    if category != "films" && params[:category].present?
      pages = []
      until result["next"].nil?
        pages << result
        new_url = result["next"]
        result = JSON.parse(open(new_url).read)
      end
      pages << result
    else
      pages = [result]
    end

    return pages
  end

  def link_save(url)
      link = Link.new(url: url)
      link.user = current_user
      link.save
  end
end
