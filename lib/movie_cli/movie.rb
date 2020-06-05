require 'pry'

class Movie
    attr_accessor :title, :id, :year, :pages, :overview, :popularity, :index
    @@all = []

    def initialize(title, year = nil, id = nil, overview, popularity)
        @title = title
        @year = year
        @overview = overview
        @id = id
        @popularity = popularity
        @index = 0
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy
        self.all.clear
    end

    def self.sort
        self.all.sort_by{|movie| movie.popularity}.reverse
    end

    def self.find_by_id(i)
        self.all.each{|movie| return movie if movie.index.to_s == i}
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

    def self.sort
        self.all.sort do |a| 
            case
            when a.job.include?("Director")
                -1
            when a.job.include?("Screenplay")
                0
            else
                1
            end
        end
    end

end

# binding.pry