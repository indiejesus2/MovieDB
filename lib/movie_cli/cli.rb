require_relative "./movie.rb"
require_relative "./api.rb"

class CLI

    def run
        welcome
        main
    end

    def main
        input = ' '
        while input != "exit"
            selection
            id = gets.strip
            menu(id)
        end
    end

    def print_names
        Movie.sort.each.with_index(1) do |movie, i|
            movie.index = i
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
            puts "Screenplay by #{crew.name}." if crew.job.include?("Screenplay")
            puts "#{crew.job} by #{crew.name}." if crew.department == "Writing" && !crew.job.include?("Screenplay")
        end
        puts " "
        Cast.all.each.with_index(1) do |cast, i| 
            cast.index = i
            if cast.index <= 20
                puts "#{cast.character} played by #{cast.actor}."
            end
        end
    end


    def recommended_movies(id)
        Api.recommended_movie(id)
        plots
    end

    def similar_movies(id)
        Api.similar_movie(id)
        plots
    end

    def plots
        Movie.all.each.with_index(1) do |m, i|
            m.index = i
            if m.index <= 5
                puts " "
                puts "#{m.title} (#{m.year})"
                puts "#{m.overview}"
            end
        end
    end

    def welcome
        puts "Welcome to MovieDB CLI!"
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
        input = gets.strip.downcase
        puts " "
        if input.include?("plot")
            print_overview(selection.id)
        elsif input.include?("cast") || input.include?("crew")
            print_cast_and_crew(selection.id)
        elsif input.include?("recommend")
            recommended_movies(selection.id)
        elsif input.include?("similar")
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