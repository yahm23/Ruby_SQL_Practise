require('pry')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'artist_name' => 'Pink Floyd'
  })
  artist1.save()

artist2 = Artist.new({
  'artist_name' => 'Foo Fighters'
  })
artist2.save()

album1 = Album.new({
  'album_name' => 'Wish You Were Here',
  'genre' => 'Rock',
  'artist_id' => artist1.id
})
album1.save()

album2 = Album.new({
  'album_name' => 'The Dark Side of the Moon',
  'genre' => 'Rock',
  'artist_id' => artist1.id
})
album2.save()

album3 = Album.new({
  'album_name' => 'The Pretender',
  'genre' => 'Rock',
  'artist_id' => artist2.id
})
album3.save()

binding.pry
nil
