class MoviesController < ApplicationController
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)  
  end
  
  def index
    @movies = Movie.all
  end
  
  def show
    id = params[:id]
    @movie = Movie.find(id)
  end
  
  def new
  end
  
  def create
    @movie = Movie.create! movie_params
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end
end