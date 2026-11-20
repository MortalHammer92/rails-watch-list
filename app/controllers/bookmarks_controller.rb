class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
      if params[:list_id]                      # venu d'une liste
        @list = List.find(params[:list_id])
        @bookmark.list = @list
      else                                     # venu d'un film
        @movie = Movie.find(params[:movie_id])
        @bookmark.movie = @movie
      end

    if @bookmark.save
      redirect_to list_path(@bookmark.list)  # on va voir la liste où le film est rangé
    elsif @list
      render "lists/show", status: :unprocessable_entity
    else
      render "movies/show", status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
