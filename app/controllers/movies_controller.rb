class MoviesController < ApplicationController
  def index
    @movies = Movie.order(year: :desc)

    if params[:query].present?
      @movies = @movies.where('title ILIKE ?', "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html # Rails classic flow
      format.text { render partial: 'list.html', locals: { movies: @movies }}
    end
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    render partial: 'movies/movie_infos', locals: { movie: @movie }
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year)
  end
end
