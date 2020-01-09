# frozen_string_literal: true

require 'csv'
require_relative 'recipe'
class Cookbook
  attr_reader :recipes
  # act as a database
  def initialize(csv_file_path)
    # take recipe from csv file
    @csv_file_path = csv_file_path
    @recipes = []
    parse
  end

  def parse
    CSV.foreach(@csv_file_path) do |row|
      # Here, row is an array of columns
      name = row[0]
      description = row[1]
      duration = row[2]
      recipe = Recipe.new(name, description, duration)
      @recipes << recipe
    end
  end

  def all
    # return all recipes
    @recipes
  end

  def add_recipe(recipe)
    # add recipe to the cookbook
    @recipes << recipe
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'w', csv_options) do |csv|
      @recipes.each do |rec|
        csv << [rec.name, rec.description, rec.duration]
      end
    end
  end

  #   def remove_recipe(recipe_index)
  #     # remove recipe from the cookbook
  #     @recipes.delete_at(recipe_index)
  #     csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  #     CSV.open(@csv_file_path, 'w', csv_options) do |csv|
  #       @recipes.each do |rec|
  #         csv << [rec.name, rec.description, rec.duration, rec.finished]
  #       end
  #     end
  #   end

  #   def finished(recipe_index)
  #     @recipes[recipe_index].mark
  #     csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  #     CSV.open(@csv_file_path, 'w', csv_options) do |csv|
  #       @recipes.each do |rec|
  #         csv << [rec.name, rec.description, rec.duration, rec.finished]
  #       end
  #     end
  #   end
end
