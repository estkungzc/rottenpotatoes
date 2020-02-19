class Movie < ApplicationRecord

    class Movie::InvalidKeyError < StandardError ; end

    def self.find_in_tmdb(string)
      begin
        Tmdb::Movie.find(string)
      rescue Tmdb::InvalidApiKeyError
        raise Movie::InvalidKeyError, 'Invalid API key'
      end
    end

end
