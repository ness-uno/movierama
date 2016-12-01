class PollingStation
  def initialize(user:, movie:)
    @user = user
    @movie = movie
  end

  def vote(preference)
    _voting_booth.vote(preference)
    _notifier.notify(preference)
  end

  def unvote
    _voting_booth.unvote
  end

  private

  attr_reader :user, :movie

  def _voting_booth
    VotingBooth.new(user, movie)
  end

  def _notifier
    Notifier.new(user: user, movie: movie)
  end
end
