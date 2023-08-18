# frozen_string_literal: true

class Outcome
  attr_accessor :success, :result

  def initialize(success: nil, result: nil)
    @success = success
    @result = result
  end

  def success?
    success
  end
end
