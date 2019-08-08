module Errors
  class CannotAddGameToEvent < Errors::StandardError
    def initialize(what: '')
      super(
        status: 400,
        title: "Cannot add game to the event",
        detail: "Cannot add game to the event",
      )
    end
  end
end