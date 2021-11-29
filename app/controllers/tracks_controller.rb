class TracksController < ApplicationController
  def index
    @album = Album.find(params[:album_id])
    @tracks = @album.tracks
  end

  def new
    @artist = Album.find(params[:album_id])
    @track = Track.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @album= Album.find(params[:album_id])
    @track = @album.tracks.create(track_params)
    if params[:commit] == 'ADD TO ALBUM & SUBMIT'
      @track.status = 'submitted'
      @album.status = 'submitted'
      @album.save
    end
    if @track.save
      redirect_to artist_profile_album_tracks_path(current_user.artist_profile, @album)
    else
      render 'new'
    end
  end

  def edit
    @track = Track.find(params[:id])
    @album = Album.find(params[:album_id])
      respond_to do |format|
        format.js
      end
  end

  def update
    @track = Track.find(params[:id])
    if params[:commit] == 'save & submit'
      @track.status = 'submitted'
      @album = Album.find(params[:album_id])
      @album.status = 'submitted'
      @album.save
    end
    @track.update(track_params)
    redirect_to artist_profile_album_tracks_path
  end

  def destroy
    @track = Track.find(params[:id])
    @album = Album.find(params[:album_id])
    @track.destroy
      redirect_to artist_profile_album_tracks_path(current_user.artist_profile, @album)
  end

  private

  def track_params
    params.require(:track).permit(:title, :album_id, :status, :song_link)
  end
end
