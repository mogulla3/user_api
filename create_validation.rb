require './validation'

class CreateValidation < Validation

  attr_accessor :user

  def validate
    return false unless self.valid_id?
    return false unless self.valid_first_name?

    true
  end

  def valid_id?
    unless @user.has_key?('id')
      self.set_error('U101', 400)
      return false 
    end

    true
  end

  def valid_first_name?

    # first_nameキーが存在しない
    unless @user.has_key?('first_name')
      self.set_error('U102', 400)
      return false 
    end

    # first_nameが空
    # if @user['first_name'].nil?
      # self.set_error('U102', 400)
      # return false 
    # end

    true
  end

  # def valid_last_name?
  # end

  # def valid_age?
  # end

  # def valid_gender?
  # end

  # def valid_mail?
  # end

  # def valid_tel?
  # end

  # def valid_hobby?
  # end

  # def valid_birth?
  # end

  # def valid_sns?
  # end

end
