class MoviesController < ApplicationController

    def index
      @movies = Movie.all
    end

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.html.haml by default
    end

    def new
      @movie = Movie.new
      # default: render 'new' template
    end

    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        flash[:notice] = "#{@movie.title} was successfully created."
        redirect_to movies_path
      else
        render 'new' # note, 'new' template can access @movie's field values!
      end
    end

    def edit
      @movie = Movie.find params[:id]
    end

    def update
      @movie = Movie.find params[:id]
      if @movie.update_attributes(movie_params)
        flash[:notice] = "#{@movie.title} was successfully updated."
        redirect_to movie_path(@movie)
      else
        render 'edit' # note, 'edit' template can access @movie's field values!
      end
    end

    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end

    def movies_with_filters
      @movies = Movie.with_good_reviews(params[:threshold])
      %w(for_kids with_many_fans recently_reviewed).each do |filter|
        @movies = @movies.send(filter) if params[filter]
      end
    end


    private

    def movie_params
      params.require(:movie).permit(:title,:rating,:release_date)
    end
    
end