class VotesController < ApplicationController
  def create
    authorize! :vote, _movie

    _polling_station.vote(_preference)
    redirect_to root_path, notice: 'Vote cast'
  end

  def destroy
    authorize! :vote, _movie

    _polling_station.unvote
    redirect_to root_path, notice: 'Vote withdrawn'
  end

  private

  def _polling_station
    PollingStation.new(user: current_user, movie: _movie)
  end

  def _preference
    case params.require(:t)
    when 'like' then Preference.for(:like)
    when 'hate' then Preference.for(:hate)
    else raise
    end
  end

  def _movie
    @_movie ||= Movie[params[:movie_id]]
  end
end
