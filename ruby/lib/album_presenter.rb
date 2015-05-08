class AlbumPresenter
  def initialize(album)
    @album = album
  end

  def artist_and_title
    "#{artists}: #{album.name}"
  end

  def uri
    album.uri
  end

  private

  attr_reader :album

  def artists
    album.artists.map(&:name).join(', ')
  end
end
