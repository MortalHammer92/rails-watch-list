class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @bookmark = Bookmark.new
  end
end
