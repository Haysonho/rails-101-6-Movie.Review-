class Account::MoviesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :join, :quit]

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

  def join
    @movie = Movie.find(params[:id])

    if !current_user.is_member?(@movie)
      current_user.join!(@movie)
      flash[:notice] = "收藏成功"
    else
      flash[:warning] = "您已收藏"
    end

    redirect_to account_movie_path(@movie)
  end

  def quit
    @movie = Movie.find(params[:id])

    if current_user.is_member?(@movie)
      current_user.quit!(@movie)
      flash[:alert] = "取消收藏"
    else
      flash[:warning] = "无法取消"
    end

    redirect_to account_movie_path(@movie)
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :review)
  end

end
