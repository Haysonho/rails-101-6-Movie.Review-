class Account::MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
  @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    @movie.save

    redirect_to account_movies_path
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :review)
  end

end
