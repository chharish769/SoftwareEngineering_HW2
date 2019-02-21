class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    #if params[:sortedmovie_by] == nil
      #@movies = Movie.all
    #else
     # @movies = Movie.order(params[:sortedmovie_by])
      #@sortedmovie_column = params[:sortedmovie_by]
      
   # end
   @movies = Movie.all.order(params[:sortedmovie_by])
    if params[:ratings]
      @movies = Movie.where({rating:  params[:ratings].keys }).order(params[:sortedmovie_by])
    end
    @sortedmovie_column = params[:sortedmovie_by]
    @all_ratings = Movie.all_ratingmovie
    @set_ratings = params[:ratings]
     if !@set_ratings
      @set_ratings = Hash.new
      @rating_first = true
    else
      @rating_first = false
    end
    
    if !@set_ratings
      @set_ratings = Hash.new
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end