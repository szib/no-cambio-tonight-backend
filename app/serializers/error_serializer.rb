class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def to_h
    serializable_hash
  end

  def to_json(payload)
    to_h.to_json
  end

  private

  def serializable_hash
    {
      error: error.serializable_hash
    }
  end

  attr_reader :error
end