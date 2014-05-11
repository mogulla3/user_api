require './validation'
require './create_validation'

class UserValidator

  attr_reader :error

  def initialize(validator, user)
    @validator = validator
    @validator.user = user
  end

  # TRUE of FALSEを返す
  def validate
    if @validator.validate == false
      @error = @validator.error
      return false
    else
      return true
    end
  end

end
