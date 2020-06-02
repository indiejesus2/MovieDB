require 'pry'

class Movie
    attr_accessor :name, :id, :year, :pages, :overview, :popularity, :index
    @@all = []

    def initialize(name, year = nil, id = nil, overview, popularity)
        @name = name
        @year = year
        @overview = overview
        @id = id
        @popularity = popularity
        @index = 0
        @@all << self
    end

    def self.all
        @@all.sort_by{|movie| movie.popularity}.reverse
    end

    def self.index
        i = 0
        until i == Movie.all.length
            self.all.each do |movie| 
                i += 1
                movie.index = i
            end
        end
    end

    def self.all_names
        all.map(&:name)
    end

    def self.destroy
        all.clear
    end

    def self.find_by_id(i)
        self.all.each{|movie| puts movie.overview if movie.index.to_s == i}
    end

end

class Cast
    attr_accessor :character, :actor
    @@all = []

    def initialize(character, actor)
        @character = character
        @actor = actor
        @@all << self
    end

    def self.all
        @@all
    end

end

class Crew
    attr_accessor :name, :job
    @@all = []

    def initialize(name, job)
        @name = name
        @job = job
        @@all << self
    end

    def self.all
        @@all
    end

end

# binding.pry