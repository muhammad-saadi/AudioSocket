class AlbumsController < ApplicationController
  before_action :get_artist, only: [:new, :index, :create]
  before_action :get_album, only: [:edit, :update, :destroy]

  def index
    @albums = @artist.albums
  end

  def new
    @album = Album.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @album = @artist.albums.create(album_params)
    if @album.save
      redirect_to albums_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @album.update!(album_params)
    redirect_to albums_path
  end

  def destroy
    @album.destroy
    redirect_to albums_path
  end

  private

  def get_artist
    @artist = current_user.artist_profile
  end

  def get_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:album_name, :artist_profile_id, :artwork)
  end
end
