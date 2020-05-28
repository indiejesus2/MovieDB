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
        res = RestClient.get(BASE_URL + KEY + "&language=en-US&query=#{string}&include_adult=false")
        data = JSON.parse(res.body)
        Movie.pages=(data["total_pages"])
        Movie.page=(data["page"])
        data['results'].each do |movie|
            # binding.pry
            name = movie["title"]
            id = movie["id"]
            year = movie["release_date"].split('-').shift if movie["release_date"]
            overview = movie["overview"]
            Movie.new(name, year, id, overview) if year
            # binding.pry
        end       
        # binding.pry
    end

    def self.next_page(string)
        Movie.destroy
        i = Movie.page
        if i != Movie.pages
            res = RestClient.get(BASE_URL + KEY + "&language=en-US&query=#{string}&include_adult=false&page=#{i+=1}")
            data = JSON.parse(res.body)
            Movie.page=(data["page"])
            data['results'].each do |movie|
                name = movie["title"]
                id = movie["id"]
                overview = movie["overview"]
                year = movie["release_date"].split('-').shift if movie["release_date"]
                Movie.new(name, year, id, overview) if year
            end
        end
    end

    def self.last_page(string)
        Movie.destroy
        i = Movie.page
        if i != Movie.pages
            res = RestClient.get(BASE_URL + KEY + "&language=en-US&query=#{string}&include_adult=false&page=#{i-=1}")
            data = JSON.parse(res.body)
            Movie.page=(data["page"])
            data['results'].each do |movie|
                name = movie["title"]
                id = movie["id"]
                overview = movie["overview"]
                year = movie["release_date"].split('-').shift if movie["release_date"]
                Movie.new(name, year, id, overview) if year
            end
        end
    end

    def self.find_movie(id)
        Movie.destroy
        res = RestClient.get(SECONDARY_URL + "#{id}/similar?api_key=" + KEY + "&language=en-US&include_adult=false")
        data = JSON.parse(res.body)
        data['results'].each do |movie|
            name = movie["title"]
            id = movie["id"]
            overview = movie["overview"]
            year = movie["release_date"].split('-').shift if movie["release_date"]
            Movie.new(name, year, id, overview) if year
        end
    end

end

# clue = Api.get_movies("clue")
# ap Movie.all
# binding.pry