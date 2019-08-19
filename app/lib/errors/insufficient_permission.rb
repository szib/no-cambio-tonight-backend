module Errors
  class InsufficientPermission < Errors::StandardError
    def initialize()
      super(
        status: 403,
        title: "Insufficient permission",
        detail: "You have no permission to do this.",
      )
    end
  end
end