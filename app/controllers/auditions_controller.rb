class AuditionsController < ApplicationController
  def new
    @audition = Audition.new
  end

  def create
    @audition = Audition.new(audition_params)
    if @audition.save
      redirect_to 'root'
    else
      render 'new'
    end
  end

  private

  def audition_params
    params.require(:audition).permit(:first_name , :last_name, :email, :artist_name, :additional_info, :source, :other_source, song_link: [], genre: [])
  end
end
