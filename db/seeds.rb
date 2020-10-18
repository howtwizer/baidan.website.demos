# Downloading zip
# https://github.com/MuseumofModernArt/collection/archive/v1.35.zip
# Unpack to TMP

require "open-uri"
require "fileutils"
require 'zip'
require "csv"

puts 'Clearing tables...'
Artist.destroy_all
Classification.destroy_all
Department.destroy_all
Artwork.destroy_all

def load_and_unzip

  IO.copy_stream(URI.open('https://zenodo.org/record/4009955/files/collection-v1.58.zip?download=1'), 'tmp/exp969mi4qx.zip')

  Zip::File.open('tmp/exp969mi4qx.zip') { |zip_file|
                                          zip_file.each { |f|
                                            f_path = File.join("tmp", f.name)
                                            FileUtils.mkdir_p(File.dirname(f_path))
                                            zip_file.extract(f, f_path) unless File.exist?(f_path)
                                          }
                                        }
end
puts 'Downloading and unzip database ...'
zip_result = load_and_unzip

puts 'Starting seeding Artists..'
CSV.foreach("tmp/Artists.csv", headers: true) do |row|
  Artist.create(
    constituent_id: row[0].to_i,
    display_name: row['DisplayName'],
    artist_bio:   row['ArtistBio'],
    nationality:  row['Nationality'],
    gender:       row['Gender'],
    begin_date:   (row['BeginDate'].to_i if row['BeginDate'].present?),
    end_date:     (row['BeginDate'].to_i if row['BeginDate'].present?),
    wiki:         row['Wiki QID'],
    ulan:         row['ULAN']
  )
end

puts 'Starting seeding Artworks..'
CSV.foreach("tmp/Artworks.csv", headers: true) do |row|
  classification = Classification.find_or_create_by!(title: row['Classification'])
  department     = Department.find_or_create_by!(title: row['Department'])
  begin
    Artwork.create!(
      constituent_id:    row['ConstituentID'].to_i,
      classification_id: classification.id,
      department_id:     department.id,
      title:             row[0],
      date:              row['Date'],
      medium:            row['Medium'],
      dimensions:        row['Dimensions'],
      credit_line:       row['CreditLine'],
      accession_number:  row['AccessionNumber'],
      date_acquired:     row['DateAcquired'],
      cataloged:         (row['Cataloged'] == 'Y'),
      url:               row['URL'],
      thumbnail_url:     row['ThumbnailURL'],
      circumference:     row['Circumference (cm)'],
      depth:             row['Depth (cm)'],
      diameter:          row['Diameter (cm)'],
      height:            row['Height (cm)'],
      length:            row['Length (cm)'],
      weight:            row['Weight (kg)'],
      width:             row['Width (cm)'],
      seat_height:       row['Seat Height (cm)'],
      duration:          row['Duration (sec.)']
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "Error '#{e.message}' in row: #{row.inspect}"
    next
  end
end


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
