# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'JSON'
require "rest-client"

puts "...clearing database"

Movie.destroy_all

puts "...Creating movies"

response = RestClient.get "http://tmdb.lewagon.com/movie/top_rated"
repos = JSON.parse(response)
  array = repos["results"]
  array.each do |obj|
    Movie.create(
      overview: obj["overview"],
      title: obj["title"],
      poster_url: ("https://image.tmdb.org/t/p/w500" + obj["poster_path"]),
      rating: obj["vote_average"].to_f
      )
  end
puts "created #{Movie.count} movies"

