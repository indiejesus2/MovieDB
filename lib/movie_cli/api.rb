require 'json'
require 'pry'
require 'rest-client'
require 'rb-readline'
require 'awesome_print'
require 'dotenv/load'

require_relative './movie.rb'

class Api
    BASE_URL = "https://api.themoviedb.org/3/search/movie?api_key="
    SECONDARY_URL = "https://api.themoviedb.org/3/movie/"
    KEY = ENV["API_KEY"]

    def self.get_movies(string)
        page = 1
        results = nil
        until results == (Movie.all.length)
            res = RestClient.get(BASE_URL + KEY + "&language=en-US&query=#{string}&include_adult=false&page=#{page}")
            data = JSON.parse(res.body)
            results = data["total_results"]
            data['results'].each do |movie|
                name = movie["title"]
                id = movie["id"]
                year = movie["release_date"].split('-').shift if movie["release_date"]
                overview = movie["overview"]
                popularity = movie["popularity"]
                Movie.new(name, year, id, overview, popularity)
            end
                page+=1
        end
    end

    def self.movie_crew(id)
        # i = id.to_i
        # binding.pry
        res = RestClient.get(SECONDARY_URL + "#{id}/credits?api_key=" + KEY)
        data = JSON.parse(res.body)
        data['cast'].each do |cast|
            character = cast["character"]
            actor = cast["name"]
            Cast.new(character, actor)
        end
        data['crew'].each do |crew|
            if crew["department"] == "Director" || crew["department"] == "Writing"
                name = crew["name"]
                job = crew["job"]
                Crew.new(name, job)
            end
        end
    end

end

# Api.get_movies("clue")
# binding.pry
# ap Movie.all
# binding.pry

# Api.movie_crew(121)
# ap Cast.all
# ap Crew.all