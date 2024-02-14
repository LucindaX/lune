class FilmingLocation < ApplicationRecord
  belongs_to :movie

  def to_s
    "(#{location}, #{country})"
  end
end
