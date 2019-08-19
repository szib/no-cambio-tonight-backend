module Errors
  class StandardError < StandardError
    def initialize(title: nil, detail: nil, status: nil)
      @title = title || "Something went wrong"
      @detail = detail || "We encountered unexpected error, but our developers had been already notified about it"
      @status = status || 500
    end

    def to_h
      {
        status: status,
        title: title,
        detail: detail,
      }
    end

    def serializable_hash
      to_h
    end

    def to_s
      to_h.to_s
    end

    attr_reader :title, :detail, :status
  end
end