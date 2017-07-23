class ReviewsController < ApplicationController
  before_filter :has_moviegoer_and_movie, :only => [:new, :create]
  protected
  def has_moviegoer_and_movie
    unless @current_user
      flash[:warning] = 'You must be logged in to create a review.'
      redirect_to '/auth/twitter'
    end
    unless (@movie = Movie.where(:id => params[:movie_id]))
      flash[:warning] = 'Review must be for an existing movie.'
      redirect_to movies_path
    end
  end
  public
  def new
    @movie = Movie.find params[:movie_id]
    @review = @movie.reviews.build
  end
  def create
    # since moviegoer_id is a protected attribute that won't get
    # assigned by the mass-assignment from params[:review], we set it
    # by using the << method on the association.  We could also
    # set it manually with review.moviegoer = @current_user.
    @movie = Movie.find params[:movie_id]
    @current_user.reviews << @movie.reviews.build(rating_params)
    redirect_to movie_path(@movie)
  end
  
  private
  
  def rating_params
    params.require(:review).permit(:comments, :potatoes)
  end  
end