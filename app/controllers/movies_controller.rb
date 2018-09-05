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
    logger.debug "Params: #{params.inspect}"
    logger.debug "Session: #{session.inspect}"
    @redirect = false
    if params[:ratings].to_s.strip.empty? && !session[:ratings].to_s.strip.empty?
        params[:ratings] = session[:ratings]
        @redirect = true
     end
    if params[:sort].to_s.strip.empty? && !session[:sort].to_s.strip.empty?
      params[:sort] = session[:sort]
      @redirect = true
    end
    if @redirect 
      logger.debug "Redirecting"
      logger.debug "Params: #{params.inspect}"
      logger.debug "Session: #{session.inspect}"
      redirect_to movies_path(params)
    end
     @all_ratings = Movie.select(:rating).distinct.order(:rating)
     @movies = Movie.all
     if !params[:ratings].to_s.strip.empty?
        session[:ratings] = params[:ratings]
        @ratingshash = params[:ratings].keys
        @movies = Movie.where(rating: @ratingshash) 
     end
    if !params[:sort].to_s.strip.empty? 
      session[:sort] = params[:sort]
      @movies = @movies.order(params[:sort])
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
