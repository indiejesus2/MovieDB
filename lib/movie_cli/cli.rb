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
        Movie.destroy
        # binding.pry
        input = ' '
        while input != "exit"
            selection
            id = gets.strip
            menu(id)
        end
    end

    def print_names
        Movie.index
        # i = 1
        Movie.all.each do |movie|
            if movie.index <= 20
                puts "#{movie.index}.) #{movie.name} (#{movie.year})"
            end
        end
    end

    def print_overview(id)
        Movie.all.each{|movie| puts "#{movie.overview}" if movie.index.to_s == id}
    end

    def print_cast_and_crew(id)
        Movie.all.each do |movie|
            if movie.index.to_s == id
                Api.movie_crew(movie.id)
                Crew.all.each do |crew|
                    puts "Directed by #{crew.name}." if crew.job == "Director"
                    puts "Written by #{crew.name}." if crew.department == "Writing"
                end
                puts " "
                Cast.index
                Cast.all.each do |cast|
                    if cast.index <= 20
                        puts "#{cast.character} played by #{cast.actor}."
                    end
                end
            end
        end
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
                Api.recommended_movie(movie.id)
                Movie.index
            end
        end
        Movie.all.each do |m|
            if m.index <= 5
                puts "#{m.name} (#{m.year})"
                puts "#{m.overview}"
                puts " "
            end
        end
    end

    def similar_movies(id)
        Movie.all.each do |movie|
            if movie.index.to_s == id
                Api.similar_movie(movie.id)
                Movie.index
            end
        end
        Movie.all.each do |m|
            if m.index <= 5
                puts "#{m.name} (#{m.year})"
                puts "#{m.overview}"
                puts " "
            end
        end
    end
    
    # def response
    #     response = gets.strip
    # end

    def welcome
        puts "Welcome to MoviesDB CLI!"
    end

    def selection
        puts "Please enter movie title"
        input = gets.strip
        Api.get_movies(input)
        print_names
        puts "Please make a selection"
    end

    def menu(id)
        selection = Movie.find_by_id(id)
        puts "Would you like the plot, cast & crew, similar movies, or recommendations based on #{selection}? Or exit?"
        response = gets.strip.downcase
        case response
        when "plot"
            print_overview(id)
        when "cast and crew"
            print_cast_and_crew(id)
        when "recommendations"
            recommended_movies(id)
        when "similar movies"
            similar_movies(id)
        else
            input = "exit"
            goodbye

        end
    end

    def goodbye
        puts "Thanks for visiting! Enjoy your movie!"
    end

    def plot(response)
        print_overview(response)
    end

        
end

# binding.pry

# CLI.new.run