#
# 汎用的なチェック部品を持たせる
#
class Validation

  attr_reader :error

  # 抽象メソッド
  def validate
    raise 'abstract method'
  end

  # error_codeに応じたメッセージをどこかで持つ
  def set_error(error_code, status_code)

    @error = {error_code: error_code, status_code: status_code, message: 'msg'}

  end

end
