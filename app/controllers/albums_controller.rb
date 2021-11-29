class AlbumsController < ApplicationController
  def index
    @artist = ArtistProfile.find(params[:artist_profile_id])
    @albums = @artist.albums
  end
  def new
    @artist = ArtistProfile.find(params[:artist_profile_id])
    @album = Album.new
    respond_to do |format|
    format.js
  end
  end

  def create
    @artist= ArtistProfile.find(params[:artist_profile_id])
    @album = @artist.albums.create(album_params)
    if @album.save
      redirect_to artist_profile_albums_path(@artist)
    else
      render 'new'
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.update!(album_params)
    redirect_to artist_profile_albums_path
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to artist_profile_albums_path
  end

  private

  def album_params
   params.require(:album).permit(:album_name, :artist_profile_id, :artwork)
  end
end
