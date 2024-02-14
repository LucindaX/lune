require 'csv'
require 'tempfile'
require 'test_helper'
require 'rake'

class ImportMoviesCsvTaskTest < ActiveSupport::TestCase
  def setup
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require('lib/tasks/import', [Rails.root.to_s])
    Rake::Task.define_task(:environment)
  end

  test 'importing movies from CSV' do
    # Create a temporary CSV file with test data
    csv_file = Tempfile.new(['test_movies', '.csv'])
    csv_file.write(<<~CSV)
    Movie,Description,Year,Director,Actor,Filming location,Country
    The Shawshank Redemption,Drama,1994,Frank Darabont,Tim Robbins,Ohio,USA
    The Godfather,Crime,1972,Francis Ford Coppola,Marlon Brando,New York,USA
    CSV
    csv_file.close

    # Pass the temporary CSV file path to the task invocation
    original_argv = ARGV.dup
    ARGV[1] = csv_file.path
    Rake::Task['import:movies_csv'].invoke()
    

    assert_equal 2, Movie.count
    assert_equal 2, FilmingLocation.count
    assert_equal 2, Actor.count
    assert_equal 2, ActorMovie.count

    # Check specific records if needed
    assert_equal 'The Shawshank Redemption', Movie.find_by(name: 'The Shawshank Redemption').name
    assert_equal 'Ohio', FilmingLocation.find_by(location: 'Ohio').location
    assert_equal 'Tim Robbins', Actor.find_by(name: 'Tim Robbins').name

    # Delete the temporary CSV file
    ARGV.replace(original_argv)
    csv_file.unlink
  end
end

