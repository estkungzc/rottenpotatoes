class Movie < ApplicationRecord
  has_many :reviews
  before_save :capitalize_title
  def capitalize_title
    self.title = title.split(/\s+/).map(&:downcase)
                      .map(&:capitalize).join(' ')
  end

  #  shortcut: array of strings
  def self.all_ratings
    %w[G PG PG-13 R NC-17]
  end

  validates :title, presence: true
  validates :release_date, presence: true
  validate :released_1930_or_later # uses custom validator below
  validates :rating, inclusion: { in: Movie.all_ratings },
                     unless: :grandfathered?

  def released_1930_or_later
    errors.add(:release_date, 'must be 1930 or later') if
      release_date && release_date < Date.parse('1 Jan 1930')
  end

  @@grandfathered_date = Date.parse('1 Nov 1968')
  def grandfathered?
    release_date && release_date < @@grandfathered_date
  end

  scope :with_good_reviews, lambda { |threshold|
                              Movie.joins(:reviews).group(:movie_id)
                                   .having(['AVG(reviews.potatoes) > ?', threshold.to_i])
                            }
  scope :for_kids, lambda {
    Movie.where('rating in (?)', %w[G PG])
  }
  
  # scope :for_kids, Movie.where('rating in ?', %w(G PG))

  scope :recently_reviewed, lambda { |n|
    Movie.joins(:reviews).where(['reviews.created_at >= ?', n.days.ago]).uniq
  }
end
