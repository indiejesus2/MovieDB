require 'json'
require 'pry'
require 'rest-client'
require 'rb-readline'
require 'awesome_print'
require 'dotenv/load'

require_relative './movie.rb'

class Api
    BASE_URL = "https://api.themoviedb.org/3/"
    KEY = ENV["API_KEY"]

    def self.get_movies(string)
        Movie.destroy
        page = 1
        results = nil
        until results == (Movie.all.length)
            res = RestClient.get(BASE_URL + "search/movie?api_key=" + KEY + "&language=en-US&query=#{string}&include_adult=false&page=#{page}")
            data = JSON.parse(res.body)
            results = data["total_results"]
            data['results'].each do |movie|
                movie_data = movie_info(movie)
                movie = Movie.new(
                    movie_data
                    )
                movie.save
            end
                page+=1
        end
    end

    def self.movie_crew(id)
        Cast.destroy
        Crew.destroy
        res = RestClient.get(BASE_URL + "movie/#{id}/credits?api_key=" + KEY)
        data = JSON.parse(res.body)
        data['cast'].each do |cast|
            character = cast["character"]
            actor = cast["name"]
            Cast.new(character, actor)
        end
        data['crew'].each do |crew|
            if crew["job"] == "Director" || crew["department"] == "Writing"
                name = crew["name"]
                department = crew["department"]
                job = crew["job"]
                Crew.new(name, job, department)
            end
        end
    end

    def self.recommended_movie(id)
        Movie.destroy_recommended
        res = RestClient.get(BASE_URL + "movie/#{id}/recommendations?api_key=" + KEY)
        data = JSON.parse(res.body)
        data['results'].each do |movie|
            movie_data = movie_info(movie)
            suggestion = Movie.new(movie_data)
            suggestion.recommend
        end
    end

    def self.similar_movie(id)
        Movie.destroy_recommended
        res = RestClient.get(BASE_URL + "movie/#{id}/similar?api_key=" + KEY)
        data = JSON.parse(res.body)
        data['results'].each do |movie|
            movie_data = movie_info(movie)
            similar = Movie.new(movie_data)
            similar.recommend
        end
    end

    def self.movie_info(movie)
        movie_data = {}
        movie_data[:title] = movie["title"]
        movie_data[:id] = movie["id"]
        movie_data[:year] = movie["release_date"].split('-').shift if movie["release_date"]
        movie_data[:overview] = movie["overview"]
        movie_data[:popularity] = movie["popularity"]
        return movie_data
    end

end

# Api.get_movies("clue")
# binding.pry
# ap Movie.all
# binding.pry

# Api.recommended_movie(121)
# ap Movie.all
# ap Cast.all
# ap Crew.all