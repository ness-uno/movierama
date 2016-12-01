class Preference
  class << self
    def for(preference)
      unless %i(like hate).include?(preference)
       raise ArgumentError.new("`#{preference}` is not valid preference")
      end
      new(preference)
    end
  end

  private_class_method :new

  attr_reader :vote

  def initialize(preference)
    @vote = preference
  end

  def like?
    vote == :like
  end

  def hate?
    vote == :hate
  end

end
