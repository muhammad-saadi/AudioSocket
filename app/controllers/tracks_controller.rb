class TracksController < ApplicationController
  before_action :get_album
  before_action :get_track, only: [:edit , :update, :destroy]
  def index
    @tracks = @album.tracks
  end

  def new
    @track = Track.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @track = @album.tracks.create(track_params)
    if params[:commit] == 'ADD TO ALBUM & SUBMIT'
      @track.status = 'submitted'
      @album.status = 'submitted'
      @album.save
    end
    if @track.save
      redirect_to album_tracks_path(@album)
    else
      render 'new'
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if params[:commit] == 'save & submit'
      @track.status = 'submitted'
      @album.status = 'submitted'
      @album.save
    end
    @track.update(track_params)
    redirect_to album_tracks_path(@album)
  end

  def destroy
    @track.destroy
    redirect_to album_tracks_path(@album)
  end

  private

  def get_album
    @album = Album.find(params[:album_id])
  end

  def get_track
    @track = Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:title, :album_id, :status, :song_link)
  end
end
