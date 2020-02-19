# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  before(:each) do
    @attr = {
      title: 'Star Wars',
      rating: 'PG',
      release_date: '1977-05-25'
    }
  end

  describe 'searching Tmdb by keyword' do
    context 'with valid API key' do
      # elided for brevity
      # it 'calls Tmdb with title keywords' do
      #   expect(Tmdb::Movie).to receive(:find).with('Inception')
      #   Movie.find_in_tmdb('Inception')
      # end
    end
    context 'with invalid API key' do
      before(:each) do
        allow(Tmdb::Movie).to receive(:find).and_raise(Tmdb::InvalidApiKeyError)
      end
      # all specs in this block can take advantage of line 10's stub
      it 'raises an InvalidKeyError' do
        expect { Movie.find_in_tmdb('Inception') }
          .to raise_error(Movie::InvalidKeyError)
      end
      # other sad-path specs here...
    end
  end

  it 'should include rating and year in full name' do
    # 'build' creates but doesn't save object; 'create' also saves it
    movie = build(:movie, title: 'Milk', rating: 'R')
    expect(movie.name_with_rating).to eq 'Milk (R)'
  end

  it 'should create a new instance given a valid attribute' do
    Movie.create!(@attr)
  end
end
