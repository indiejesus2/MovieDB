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
        @@all.sort_by{|movie| movie.popularity}.reverse
    end

    def self.index
        self.all.each.with_index(1) {|movie, i| movie.index = i}
    end

    def self.all_names
        all.map(&:title)
    end

    def self.destroy
        self.all.clear
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

    def self.index
        self.all.each.with_index {|cast, i| cast.index = i}
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
        # binding.pry
        sorted = self.all.sort_by {|a| a.department}
        # binding.pry
    end

end

# binding.pry