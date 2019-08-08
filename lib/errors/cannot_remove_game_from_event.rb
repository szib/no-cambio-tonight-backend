module Errors
  class CannotRemoveGameFromEvent < Errors::StandardError
    def initialize(what: '')
      super(
        status: 400,
        title: "Cannot remove game from the event",
        detail: "Cannot remove game from the event",
      )
    end
  end
end