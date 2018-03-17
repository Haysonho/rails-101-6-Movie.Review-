class Account::CommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @movie = Movie.find(params[:movie_id])
    @comment = Comment.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = Comment.new(comment_params)
    @comment.movie = @movie
    @comment.user = current_user

    if @comment.save
      redirect_to account_movies_path(@movie)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end


end
