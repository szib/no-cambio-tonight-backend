module Errors
  class CannotCreate < Errors::StandardError
    def initialize(what: '')
      super(
        status: 400,
        title: "Cannot create #{what}.",
        detail: "Cannot create #{what}. Try again later.",
      )
    end
  end
end