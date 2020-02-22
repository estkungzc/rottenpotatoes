class ReviewsController < ApplicationController

    before_action :has_moviegoer_and_movie, :only => [:new, :create]
    protected
    def has_moviegoer_and_movie
      unless @current_user
        flash[:warning] = 'You must be logged in to create a review.'
        redirect_to movies_path
      end
      unless (@movie = Movie.where(:id => params[:movie_id]))
        flash[:warning] = 'Review must be for an existing movie.'
        redirect_to movies_path
      end
    end
    public

    def index
      @movie = Movie.find(params[:movie_id])
      # new sets movie_id foreign key automatically
      @review ||= @movie.reviews.where(:movie => params[:movie_id])
      @review = @review || @movie.reviews
    end

    def new
      # movie_id because of nested route
      @movie = Movie.find(params[:movie_id])
      # new sets movie_id foreign key automatically
      @review ||= @movie.reviews.new
      @review = @review || @movie.reviews

      # @review = @movie.reviews.build
    end
    def create
      # # movie_id because of nested route
      # @movie = Movie.find(params[:movie_id])

      # # build sets the movie_id foreign key automatically
      # @review = @movie.reviews.build(params[:review])

      # if @review.save
      #   flash[:notice] = 'Review successfully created.'
      #   redirect_to(movie_reviews_path(@movie))
      # else
      #   render :action => 'new'
      # end

      # movie_id because of nested route
      @movie = Movie.find(params[:movie_id])
      # new sets movie_id foreign key automatically
      @review ||= @movie.reviews.new(review_params)
      @review = @review || @movie.reviews

      # since moviegoer_id is a protected attribute that won't get
      # assigned by the mass-assignment from params[:review], we set it
      # by using the << method on the association.  We could also
      # set it manually with review.moviegoer = @current_user.

      @current_user.reviews << @review
      if @review.save
        flash[:notice] = 'Review successfully created.'
        redirect_to(movie_reviews_path(@movie))
      else
        render :action => 'new'
      end
    end

    private
    def review_params
      params.require(:review).permit(:potatoes, :comments, :moviegoer, :movie)
    end
end