#application environment
require "bundler/setup"
Bundler.require(:default)

require 'dotenv/load'

require_relative "./movie_cli/api.rb"
require_relative "./movie_cli/cli.rb"
require_relative "./movie_cli/movie.rb"