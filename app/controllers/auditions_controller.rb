class AuditionsController < ApplicationController
  def new
    @audition = Audition.new
  end

  def create
    @audition = Audition.new(get_params)
    # @audition.genre = params[:audition][:genre]
    if @audition.save
      redirect_to 'root'
    else
      render 'new'
    end
  end

  private
  def get_params
    params.require(:audition).permit(:first_name , :last_name, :email, :artist_name, :additional_info, :source, :other_source, song_link: [], genre: [])
  end
end
