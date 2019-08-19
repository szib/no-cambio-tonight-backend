module Errors
  class Unauthorized < Errors::StandardError
    def initialize
      super(
        status: 401,
        title: "Unauthorized",
        detail: "You need to login to authorize this request.",
      )
    end
  end
end