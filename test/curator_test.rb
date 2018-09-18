require 'minitest/pride'
require 'minitest/autorun'
require './lib/curator'
require './lib/artist'
require './lib/photograph'
require 'pry'

class ArtistTest < Minitest::Test

  def setup
    @curator = Curator.new
    
    @photo_1 = Photograph.new(attributes = {id: "1", name: "Rue Mouffetard, Paris (Boy with Bottles)", artist_id: "1", year: "1954"})
    @photo_2 = Photograph.new(attributes = {id: "2", name: "Moonrise, Hernandez", artist_id: "2", year: "1941"})
    @photo_3 = Photograph.new(attributes = {id: "3", name: "Identical Twins, Roselle, New Jersey", artist_id: "3", year: "1967"})
    @photo_4 = Photograph.new(attributes = { id: "4", name: "Child with Toy Hand Grenade in Central Park", artist_id: "3", year: "1962"})

    @artist_1 = Artist.new(attributes = {id: "1", name: "Henri Cartier-Bresson", born: "1908", died: "2004", country: "France" }) 
    @artist_2 = Artist.new(attributes = {id: "2", name: "Ansel Adams", born: "1902", died: "1984", country: "United States" })
    @artist_3 = Artist.new(attributes = {id: "3", name: "Diane Arbus", born: "1923", died: "1971", country: "United States"})
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end
  
  def test_artists_and_photos_start_off_empty
    assert_equal [], @curator.artists 
    assert_equal [], @curator.photographs
    assert_equal 0, @curator.artists.count
    assert_equal 0, @curator.photographs.count
  end

  def test_it_can_add_photograph
    @curator.add_photograph(@photo_1)
   
    assert_equal [@photo_1], @curator.photographs
    assert_equal 1, @curator.photographs.count
  end

  def test_add_multiple_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    expected = [@photo_1, @photo_2]
    
    assert_equal expected, @curator.photographs
  end

  def test_photographs_still_have_attributes
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
   
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @curator.photographs.first.name
  end

  def test_it_can_add_artist
    @curator.add_artist(@artist_1)
    
    assert_equal [@artist_1], @curator.artists
    assert_equal 1, @curator.artists.count
  end

  def test_it_can_add_multiple_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
   
    assert_equal [@artist_1, @artist_2], @curator.artists
    assert_equal 2, @curator.artists.count
  end

  def test_photographs_still_have_attributes
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
  end

  def test_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_find_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_find_photos_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    
    diane_arbus = @curator.find_artist_by_id("3")
    assert_equal [@photo_3, @photo_4], @curator.find_photographs_by_artist(diane_arbus)
  end
  
  def test_find_multiple_photos_by_artist
    
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    
    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_find_photos_by_artist_country
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    
    assert_equal [@photo_2, @photo_3, @photo_4], @curator.photographs_taken_by_artist_from("United States")
  end

  def test_country_search_returns_empty_if_country_not_found
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    assert_equal [], @curator.photographs_taken_by_artist_from("Argentina")
  end
end