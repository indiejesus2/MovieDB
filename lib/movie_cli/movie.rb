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
        @@all = []
    end

    def self.find_by_id(i)
        self.all.each{|movie| return movie.name if movie.index.to_s == i}
    end

end

class Cast
    attr_accessor :character, :actor, :index
    @@all = []

    def initialize(character, actor)
        @character = character
        @actor = actor
        @index = 0
        @@all << self
    end

    def self.all
        @@all
    end

    def self.index
        i = 0
        until i == Cast.all.length
            self.all.each do |cast| 
                i += 1
                cast.index = i
            end
        end
    end

    def self.destroy
        self.all.clear
    end

end

class Crew
    attr_accessor :name, :job, :department
    @@all = []

    def initialize(name, job, department)
        @name = name
        @job = job
        @department = department
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy
        self.all.clear
    end
    

end

# binding.pry