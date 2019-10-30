require('pg')
require_relative('../db/sql_runner.rb')
require_relative('artist.rb')

class Album

attr_reader :id, :album_name, :artist_id
attr_accessor :genre

def initialize( options )
  @id = options['id'].to_i if options['id']
  @album_name = options['album_name']
  @genre = options['genre']
  @artist_id = options['artist_id'].to_i
end

def save()
  sql = "INSERT INTO albums
  (album_name,
  genre,
  artist_id
)
  VALUES
  ($1, $2, $3)
  RETURNING id;"
  values = [@album_name, @genre, @artist_id]
  result = SqlRunner.run( sql, values )
  @id = result[0]['id'].to_i
end

def update()
  sql = "UPDATE albums SET (
  album_name,
  genre,
  artist_id
)
=
(
  $1, $2, $3
)
  WHERE id = $4;"
  values = [@album_name, @genre, @artist_id, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM albums WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.find_by_artist(artist)
  sql = "SELECT * FROM albums WHERE artist_id = $1"
  values = [artist.id]
  results = SqlRunner.run(sql, values)
  return results.map {
    |result| Album.new(result)
   }
end

def artist()
  sql = 'SELECT * FROM artists WHERE id = $1;'
  values = [@artist_id]
  results = SqlRunner.run(sql, values)
  artist_info = results[0]
  return Artist.new(artist_info)
end

# def self.find_artist_name(album)
#   sql = 'SELECT * FROM albums WHERE album_name = $1
#   RETURNING artist_id'
#   values = [album.album_name]
#   artist_id = SqlRunner.run(sql, values)
#   result = artist_id[0]['artist_id'].to_i
#
# end

def self.find_by_id(id)
  sql = "SELECT * FROM albums WHERE id = $1;"
  values = [id]
  result = SqlRunner.run(sql, values)
  album = result[0]
  output = Album.new(album)
  return output
end

def self.delete_all()
  sql = "DELETE FROM albums;"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM albums"
  results = SqlRunner.run(sql)
  return results.map {
    |result| Album.new(result)
  }
end

end
