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
        id = response
        menu
        case response
        # binding.pry
            when "plot"
                print_overview(id)
            when "cast"
                print_cast(id)
            end
        continue
        response
        # binding.pry
        # binding.pry
        # while Movie.page != Movie.pages
        #     puts "Make selection or list more?"
        #     response = gets.strip
        #     if response.include?("more")
        #         Api.next_page(input)
        #         print_names
        #     elsif response.include?("selection")
        #         puts "Make your selection by ID"
        #         response = gets.strip
        #         # print_overview(response)
        #         Api.find_movie(response)
        #         recommended_movies
        #         # Movie.find_by_id(response)
        #     end
        #     if Movie.page >= 2
        #         puts "Make selection, list more, or list less?"
        #         response = gets.strip
        #         if response.include?("more")
        #             Api.next_page(input)
        #             print_names
        #         elsif response.include?("selection")
        #             puts "Make your selection by ID"
        #             response = gets.strip
        #             print_overview(response)
        #         elsif response.include?("less")
        #             Api.last_page(input)
        #             print_names
        #         end
        #     end
        #     if Movie.page == Movie.pages
        #         puts "Make a selection by ID"
        #         response = gets.strip
        #         print_overview(response)
        #     end
        # end
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
        Movie.all.find{|movie| puts "#{movie.overview}" if movie.index.to_s == id}
    end

    def print_cast(id)
        Movie.all.find {|movie|
            if movie.index.to_s == id
                Api.movie_crew(movie.id)
                Cast.all.find{|cast| puts "#{cast.character} = #{cast.actor}"}
            end
        }
    end

    def recommended_movies
        Movie.all.each{|m| puts "#{m.name.capitalize} (#{m.year}) #{m.overview}"}
    end
    
    def response
        response = gets.strip
    end

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