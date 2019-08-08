module Errors
  class NotFound < Errors::StandardError
    def initialize(what: '')
      super(
        status: 404,
        title: "#{what} not found.",
        detail: "#{what} not found.",
      )
    end
  end
end