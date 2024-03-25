class ApplicationOperation
  STATUSES = [
    SUCCESS = :success,
    FAILURE = :failure,
  ].freeze

  class << self
    def execute(**params)
      new.execute(**params)
    end
  end

  def execute
    fail NotImplementedError
  end

  def success(**payload)
    Result.new(SUCCESS, payload)
  end

  def failure(**payload)
    Result.new(FAILURE, payload)
  end

  class Result
    def initialize(status, payload = {})
      @status = status
      @payload = payload
    end

    def success?
      status == SUCCESS
    end

    def method_missing(method_name, *)
      payload.key?(method_name) ? payload[method_name] : super
    end

    def respond_to_missing?(method_name)
      payload.key?(method_name) || super
    end

    private

    attr_reader :status, :payload
  end
end
