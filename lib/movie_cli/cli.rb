require_relative "./movie.rb"
require_relative "./api.rb"

class CLI
    @@id = 0

    def run
        welcome
        main
    end

    def main
        input = ' '
        movie_titles
        selection
        while input != "exit"    
            menu(@@id)
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
        Movie.recommended.each.with_index(1) do |m, i|
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

    def movie_titles
        # puts " "
        puts "Please enter movie title"
        input = gets.strip
        Api.get_movies(input)
        puts " "
        if Movie.all.length > 0
            print_names
        else
            movie_error
        end
    end

    def selection
        puts " "
        puts "Please make a selection"
        id = gets.strip.to_i
        if id <= 20 && id > 0
            @@id = id
        else
            selection_error
        end
    end

    def menu(id)
        movie = Movie.find_by_id(id)
        # binding.pry
        puts "Please enter plot, cast & crew, similar movies, or recommendations based on #{movie.title}? Or Search again or Exit?"
        input = gets.strip.downcase
        puts " "
        if input.include?("plot")
            print_overview(movie.id)
        elsif input.include?("cast") || input.include?("crew")
            print_cast_and_crew(movie.id)
        elsif input.include?("recommend")
            recommended_movies(movie.id)
        elsif input.include?("similar")
            similar_movies(movie.id)
            # binding.pry
        elsif input.include?("exit")
            goodbye
        elsif input.include?("search")
            main
        else
            menu_error
        end
        puts " "
    end

    def goodbye
        puts "Thanks for visiting! Enjoy your movie!"
        exit
    end

    def movie_error
        puts "Try again"
        puts " "
        main
    end

    def selection_error
        puts "Try again"
        puts " "
        selection
    end

    def menu_error
        puts "Try again"
        puts " "
        menu(@@id)
    end

end