class TopController < ApplicationController
  def index
    @restaurants = Restaurant.all.includes(:pref, :category)
  end
end
