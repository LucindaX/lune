class MoviesController < ApplicationController

  def index
    if params[:actor].present?
      @movies = Actor.where("name LIKE ?","%#{params[:actor]}%").first&.movies || []
    else
      @movies = Movie.all
    end
  end

  def search
  end
end
