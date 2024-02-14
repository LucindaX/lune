namespace :import do
  desc "Import movies from CSV"
  task movies_csv: :environment do
    require 'csv'

    # Check if a file path argument is provided
    file_path = ARGV[1]

    if file_path.nil?
      puts "Please provide the path to the CSV file."
      puts "Usage: rails import:movies_csv['path/to/your/csv/file.csv']"
      exit
    end

    BATCH_SIZE = 1000

    CSV.foreach(file_path, headers: true).each_slice(BATCH_SIZE) do |rows|

      movies = []

      rows.each do |row|
        title = row['Movie']
        description = row['Description']
        year = row['Year']
        director = row['Director']
        actor = row['Actor']
        filming_location = row['Filming location']
        country = row['Country']

        movie = { 
          name: title,
          description: description,
          year: year,
          director: director,
          actor: actor,
          filming_location: filming_location,
          country: country
        }

        movies << movie
      end

      process_batch(movies)
    end
  end

  def process_batch(movies)
    movies_by_name = movies.group_by { |movie| movie[:name] }
    movies_by_name.each do |name, list|
      
      filming_locations = list.map { |m| [m[:filming_location], m[:country]] }.uniq
      
      movie = list.first
      movie_created = Movie.where(name: name, 
                   description: movie[:description],
                   director: movie[:director],
                   year: movie[:year]).first_or_create

      filming_locations.each do |fl|
        FilmingLocation.where(location: fl.first, country: fl.last, movie: movie_created).first_or_create
      end


      actors = list.map { |m| m[:actor] }.uniq
      actors.each do |actor|
        actor_created = Actor.where(name: actor).first_or_create
        ActorMovie.where(actor: actor_created, movie: movie_created).first_or_create
      end
    end
  end
end
