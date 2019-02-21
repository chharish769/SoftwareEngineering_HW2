class Movie < ActiveRecord::Base
    def self.all_ratingmovie
    movie_array = Array.new
    self.select("rating").uniq.each{ |items| movie_array.push(items.rating)}
    movie_array.sort.uniq
    end
end
