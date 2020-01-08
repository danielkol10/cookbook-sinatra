# frozen_string_literal: true

class Recipe
  attr_reader :name, :description, :duration, :finished
  def initialize(name, description, duration, finished)
    @name = name
    @description = description
    @duration = duration
    @finished = finished
  end

  def mark
    @finished = true
  end
end
