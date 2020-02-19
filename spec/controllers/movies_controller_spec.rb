require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Movie. As you add validations to Movie, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      title: 'test title',
      rating: 'test rating',
      description: 'desc',
      release_date: 'date',
    }
    # skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MoviesController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  
  describe "GET #index" do
    it "returns a success response" do
      Movie.create! valid_attributes
      get :index, {}, valid_session
      expect(response).to be_successful
    end
  end

  # describe "DELETE #destroy" do
  #   it "destroys the requested movie" do
  #     movie = Movie.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => movie.to_param}, valid_session
  #     }.to change(Movie, :count).by(-1)
  #   end

  #   it "redirects to the movies list" do
  #     movie = Movie.create! valid_attributes
  #     delete :destroy, {:id => movie.to_param}, valid_session
  #     expect(response).to redirect_to(movies_url)
  #   end
  # end

  # describe 'searching TMDb' do
  #   before :each do
  #     @fake_results = [double('movie1'), double('movie2')]
  #   end
  #   it 'calls the model method that performs TMDb search' do
  #     expect(Movie).to receive(:find_in_tmdb).with('hardware').
  #       and_return(@fake_results)
  #     post :search_tmdb, params: {:search_terms => 'hardware'}
  #   end
  #   describe 'after valid search' do
  #     before :each do
  #       allow(Movie).to receive(:find_in_tmdb).and_return(@fake_results)
  #       post :search_tmdb, params: {:search_terms => 'hardware'}
  #     end
  #     it 'selects the Search Results template for rendering' do
  #       expect(response).to render_template('search_tmdb')
  #     end
  #     it 'makes the TMDb search results available to that template' do
  #       expect(assigns(:movies)).to eq(@fake_results)
  #     end
  #   end
  # end
end