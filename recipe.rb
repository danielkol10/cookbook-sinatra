# frozen_string_literal: true

class Recipe
  attr_reader :name, :description, :duration

  def initialize(name, description, duration)
    @name = name
    @description = description
    @duration = duration
  end
end
