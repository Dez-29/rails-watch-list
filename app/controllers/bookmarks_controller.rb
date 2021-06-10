class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @movie = Movie.new
    @bookmark = Bookmark.new
  end
  
  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark.movie = @movie
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end
  
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie, :list)
  end
end
