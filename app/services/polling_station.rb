class PollingStation
  def initialize(user: , movie: )
    @user = user
    @movie = movie
  end

  def vote(like_or_hate)
    assert_valid_vote!(like_or_hate)
    _voting_booth.vote(like_or_hate)
  end

  def unvote
    _voting_booth.unvote
  end

  private

  attr_reader :user, :movie

  def assert_valid_vote!(like_or_hate)
    unless %i(like hate).include? like_or_hate
      raise ArgumentError.new("`#{like_or_hate}` is not a valid vote")
    end
  end

  def _voting_booth
    VotingBooth.new(user, movie)
  end
end
