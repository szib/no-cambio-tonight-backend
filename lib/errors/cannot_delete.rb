module Errors
  class CannotDelete < Errors::StandardError
    def initialize(what: '')
      super(
        status: 400,
        title: "Cannot delete #{what}.",
        detail: "Cannot delete #{what}. Try again later.",
      )
    end
  end
end