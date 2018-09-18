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
   grouped = @artists.map do |artist|
      find_photographs_by_artist(artist)
    end
    grouped.keep_if do |group|
      group[0].artist_id.length > 1
    end
  end
end