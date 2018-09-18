require 'pry'
class Curator
  
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id  == id
    end
  end

  def find_photograph_by_id(id)
      @photographs.find do |photograph|
        photograph.id  == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    most = @photographs.max_by do |element|
      element.artist_id
    end
      @artists.find_all do |element|
        element.id == most.artist_id
    end
  end

  def photographs_taken_by_artist_from(country)
    filtered_artist =  @artists.keep_if do |artist|
      artist.country == country
     end
     filtered_artist.map do |element|
      find_photographs_by_artist(element)
     end.flatten
  end


end