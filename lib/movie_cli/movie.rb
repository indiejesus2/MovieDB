require 'pry'

class Movie
    attr_accessor :name, :id, :year, :pages, :overview
    @@all = []
    @@pages = 1
    @@page = 1

    def initialize(name, year, id = nil, overview)
        @name = name
        @year = year
        @overview = overview
        @id = id
        @@all << self
    end

    # def pages=(pages)
    #     @pages = pages
    # end

    def self.pages
        @@pages
    end

    def self.pages=(pages)
        @@pages = pages
    end

    def self.page
        @@page
    end

    def self.page=(page)
        @@page = page
    end

    def next_page
        @@page += 1
    end


    def self.all
        @@all
    end

    def self.index
        all.map.with_index(1){|movie| movie.id}
    end

    def self.all_names
        all.map(&:name)
    end

    def self.destroy
        all.clear
    end

    def self.find_by_id(i)
        all.find{|movie| puts "#{movie.overview}" if movie.id == i}
    end

        # if current_list.include?(index)
        #     puts id
        #     binding.pry
        # end
    # end

    # def self.pages
    #     @@pages
    # end

end

# binding.pry