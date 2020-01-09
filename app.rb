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
cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  recipe = Recipe.new(params[:name], params[:description])
  cookbook.add_recipe(recipe)
  redirect to '/'
end
