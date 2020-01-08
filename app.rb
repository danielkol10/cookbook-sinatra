# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get '/' do
  @recipes = []
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  params.to_s
  # name = params[:name]
  # description = params[:description]
  # duration = params[:duration]
  # finished = params[:finished]
  # recipe = Recipe.new(name, description, duration, finished)
  # @cookbook.add_recipe(recipe)
  # @recipes << [name, description, duration, finished]
  # erb :index
end
