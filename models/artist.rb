require('pg')
require_relative('../db/sql_runner.rb')
require_relative('album.rb')

class Artist

attr_reader :id
attr_accessor :artist_name

def initialize( options )
  @id = options['id'].to_i if options['id']
  @artist_name = options['artist_name']
end

def save()
  sql = "INSERT INTO artists
  (artist_name)
  VALUES
  ($1)
  RETURNING id;"
  values = [@artist_name]
  result = SqlRunner.run( sql, values )
  @id = result[0]['id'].to_i
end

def update()
  sql = "UPDATE artists SET (
  artist_name
)
=
(
  $1
)
  WHERE id = $2;"
  values = [@artist_name, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM artists WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM artists;"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM artists"
  results = SqlRunner.run(sql)
  return results.map {
    |result| Artist.new(result)
  }
end

def self.find_by_id(id)
  sql = "SELECT * FROM artists WHERE id = $1;"
  values = [id]
  result = SqlRunner.run(sql, values)
  artist = result[0]
  output = Artist.new(artist)
  return output
end 






end
