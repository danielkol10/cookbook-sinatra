# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end
require_relative 'cookbook'
require_relative 'recipe'
require_relative 'service'

cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
# SERVICE = Service.new
get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

get '/import' do
  erb :import
end

post '/import' do
  @search_results = Service.search(params[:name])
  erb :results
  # take the @search_results array scraped from marmiton
  # and add the index the user wants to add with cookbook.add_recipe(@search_results(user_chose_index))
  # cookbook.add_recipe(@search_results)
end

get '/add' do
  @recipe = Recipe.new(params[:name], params[:description], params[:duration])
  cookbook.add_recipe(@recipe)
  redirect '/'
end

post '/recipes' do
  recipe = Recipe.new(params[:name], params[:description], params[:duration])
  cookbook.add_recipe(recipe)
  redirect to '/'
end

# post '/imports' do
#   # ask for ingredient
#   ingredient = params[:name]
#   # call Service.search with the ingredient inputted
#   search_results = Service.search(ingredient)
#   # list the recipes that come from the Service call
#   @view.list_recipes(search_results)
#   # ask for a number from the list to choose from
#   list_index = @view.ask_for('index').to_i - 1
#   # add that index to the cookbook
#   @cookbook.add_recipe(search_results[list_index])
# end

get '/recipes/:recipe_index' do
  cookbook.remove_recipe(params[:recipe_index].to_i)
  redirect to '/'
end
