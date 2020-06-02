require_relative "./movie.rb"
require_relative "./api.rb"
# require 'awesome_print'
# require 'bundler/setup'
# Bundler.require(:default)

class CLI
    def run
        welcome
        main
    end

    def main
        input = gets.strip
        Api.get_movies(input)
        print_names
        selection
        id = gets.strip
        menu
        response = gets.strip


        case response
        when "plot"
            print_overview(id)
        when "cast"
            print_cast(id)
        when "crew"
            print_crew(id)
        when "recommendations"
            recommended_movies(id)
        when "similar movie"
            similar_movies(id)
        end
        # end
        continue
        response
        # case response
        
        # when "search"
    end

    def print_names
        Movie.index
        # i = 1
        Movie.all.each do |movie|
            if movie.index <= 20
                puts "#{movie.index}.) #{movie.name.capitalize} (#{movie.year})"
            end
        end
    end

    def print_overview(id)
        # Movie.all.each{|movie| puts "#{movie.overview}" if movie.index.to_s == id}
        Movie.find_by_id(id)
    end

    def print_cast(id)
        Movie.all.each {|movie|
            if movie.index.to_s == id
                Api.movie_crew(movie.id)
                Cast.all.each{|cast| puts "#{cast.character} = #{cast.actor}"}
            end
        }
    end

    def print_crew(id)
        Movie.all.each do |movie|
            if movie.index.to_s == id
                Api.movie_crew(movie.id)
                Crew.all.each{|crew| puts "#{crew.job} = #{crew.name}"}
            end
        end
    end

    def recommended_movies(id)
        Movie.all.each do |movie|
            if movie.index.to_s == id
                binding.pry
                Api.recommended_movie(movie.id)
                # binding.pry
                Movie.all.each do |m| 
                    puts "#{m.name.capitalize} (#{m.year})"
                    # puts "#{m.overview}"
                end
            end
        end
    end
    
    # def response
    #     response = gets.strip
    # end

    def welcome
        puts "Welcome to MoviesDB CLI!"
        puts "Please enter movie title"
    end

    def selection
        puts "Please make a selection"
    end

    def menu
        puts "Would you like plot, cast, crew, or recommendations based on your selection?"
    end

    def continue
        puts "Search again or exit?"
    end

    def plot(response)
        print_overview(response)
    end

        
end

# binding.pry

# CLI.new.run