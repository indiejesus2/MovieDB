require_relative "./movie.rb"
require_relative "./api.rb"

class CLI

    def run
        welcome
        main
    end

    def main
        Movie.destroy
        input = ' '
        while input != "exit"
            selection
            id = gets.strip
            menu(id)
        end
    end

    def print_names
        Movie.index
        Movie.all.each do |movie|
            if movie.index <= 20
                puts "#{movie.index}.) #{movie.title} (#{movie.year})"
            end
        end
    end

    def print_overview(id)
        Movie.all.each{|movie| puts "#{movie.overview}" if movie.id == id}
    end

    def print_cast_and_crew(id)
        Api.movie_crew(id)
        Crew.sort.each do |crew|
            puts "Directed by #{crew.name}." if crew.job == "Director"
            puts "#{crew.job} by #{crew.name}." if crew.department == "Writing"
        end
        puts " "
        Cast.index
        Cast.all.each do |cast|
            if cast.index <= 20
                puts "#{cast.character} played by #{cast.actor}."
            end
        end
    end


    def recommended_movies(id)
        Api.recommended_movie(id)
        Movie.index
        Movie.all.each do |m|
            if m.index <= 5
                puts " "
                puts "#{m.title} (#{m.year})"
                puts "#{m.overview}"
            end
        end
    end

    def similar_movies(id)
        Api.similar_movie(id)
        Movie.index
        Movie.all.each do |m|
            if m.index <= 5
                puts " "
                puts "#{m.title} (#{m.year})"
                puts "#{m.overview}"
            end
        end
    end

    def welcome
        puts "Welcome to MoviesDB CLI!"
    end

    def selection
        puts " "
        puts "Please enter movie title"
        input = gets.strip
        Api.get_movies(input)
        puts " "
        print_names
        puts " "
        puts "Please make a selection"
    end

    def menu(i)
        selection = Movie.find_by_id(i)
        puts "Would you like the plot, cast & crew, similar movies, or recommendations based on #{selection.title}? Or exit?"
        response = gets.strip.downcase
        puts " "
        if response.include?("plot")
            print_overview(selection.id)
        elsif response.include?("cast") || response.include?("crew")
            print_cast_and_crew(selection.id)
        elsif response.include?("recommend")
            recommended_movies(selection.id)
        elsif response.include?("similar")
            similar_movies(selection.id)
        elsif "exit"
            goodbye
        else
            puts "Try again"
        end
    end

    def goodbye
        puts "Thanks for visiting! Enjoy your movie!"
        abort
    end

end

# binding.pry

# CLI.new.run