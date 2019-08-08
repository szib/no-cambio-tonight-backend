module Errors
  class InvalidCredentials < Errors::StandardError
    def initialize
      super(
        status: 401,
        title: "Invalid credentials",
        detail: "Invalid username or password.",
      )
    end
  end
end