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
        # binding.pry
        print_names
        binding.pry
        while Movie.page != Movie.pages
            puts "Make selection or list more?"
            response = gets.strip
            if response.include?("more")
                Api.next_page(input)
                print_names
            elsif response.include?("selection")
                puts "Make your selection by ID"
                response = gets.strip
                print_overview(response)
                # Api.find_movie(response)
                # recommended_movies
                # Movie.find_by_id(response)
            end
            if Movie.page >= 2
                puts "Make selection, list more, or list less?"
                response = gets.strip
                if response.include?("more")
                    Api.next_page(input)
                    print_names
                elsif response.include?("selection")
                    puts "Make your selection by ID"
                    response = gets.strip
                    print_overview(response)
                elsif response.include?("less")
                    Api.last_page(input)
                    print_names
                end
            end
            if Movie.page == Movie.pages
                puts "Make a selection by ID"
                response = gets.strip
                print_overview(response)
            end
        end
    end

    def print_names
        Movie.all.each.with_index(1){|p, i| puts "#{i}.) #{p.name.capitalize} (#{p.year}) (#{p.id})"}
    end

    def print_overview(id)
        Movie.all.each do |movie|
            if movie.id.to_s.include?(id)
                puts "#{movie.overview}"
            end
        end
        # binding.pry
    end

    def recommended_movies
        Movie.all.each{|m| puts "#{m.name.capitalize} (#{m.year}) #{m.overview}"}
    end

    def welcome
        puts "Welcome to MoviesDB CLI!"
        puts "Please enter movie title"
    end

    def selection
        puts "Please make a selection"
        # response = gets.strip
    end
        
end

# binding.pry

# CLI.new.run