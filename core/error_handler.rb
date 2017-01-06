require('singleton')

class ErrorHandler
  include Singleton

  attr_reader :errors

  def initialize
    @errors = Array.new
  end

  def register_error(error)
    @errors.push(error)
  end
end