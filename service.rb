# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require_relative 'cookbook'
require_relative 'recipe'

class Service
  def self.search(recipe_name)
    @recipe_name = recipe_name
    recipes_array = []
    url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@recipe_name}"
    html_string = open(url).read
    html_doc = Nokogiri::HTML(html_string)
    html_doc.search('.recipe-card').each do |element|
      name = element.search('.recipe-card__title').text.strip
      description = element.search('.recipe-card__description').text.strip
      duration = element.search('.recipe-card__duration__value').text.strip
      recipes_array << Recipe.new(name, description, duration)
    end
    recipes_array
  end
end
