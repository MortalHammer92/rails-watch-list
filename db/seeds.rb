require "open-uri"
require "json"

puts "Nettoyage de la base..."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "Création des films..."
url = "https://tmdb.lewagon.com/movie/top_rated"
data = JSON.parse(URI.open(url).read)
data["results"].each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"].round(1)
  )
end

puts "Création des listes..."
hero = List.create!(name: "Hero Movies", image_url: "https://image.tmdb.org/t/p/w500/360qdtu2hLnqMu8SVHMywn420w1.jpg")
adventure = List.create!(name: "Adventure Movies", image_url: "https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg")
action = List.create!(name: "Action Movies", image_url: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg")

puts "Création des signets..."
Bookmark.create!(list: hero, movie: Movie.first, comment: "Bane at his best")
Bookmark.create!(list: adventure, movie: Movie.find_by(title: "The Lord of the Rings: The Return of the King"), comment: "The perfect ending")
Bookmark.create!(list: action, movie: Movie.find_by(title: "The Dark Knight"), comment: "Best Joker ever")

puts "Terminé : #{Movie.count} films, #{List.count} listes, #{Bookmark.count} signets"
