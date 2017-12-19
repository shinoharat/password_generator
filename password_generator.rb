class PasswordGenerator
  class BadPasswordError < StandardError; end

  UPPER_CASE_LETTERS = [*'A'..'Z'].freeze
  LOWER_CASE_LETTERS = [*'a'..'z'].freeze
  NUMBER_LETTERS     = [*'0'..'9'].freeze
  CONFUSING_LETTERS  = ['O', '0', 'I', 'l', '1'].freeze

  def generate(length: 8, exclude_confusing_letters: true)
    fail BadPasswordError, 'パスワードは8文字以上にしてください' if length < 8

    password = "".dup
    password << get_random_letter(:upper_case, exclude_confusing_letters)
    password << get_random_letter(:lower_case, exclude_confusing_letters)
    password << get_random_letter(:number, exclude_confusing_letters)

    (length - password.length).times do
      type = [:upper_case, :lower_case, :number].sample
      password << get_random_letter(type, exclude_confusing_letters)
    end

    password
  end

  private

  def get_random_letter(type, exclude_confusing_letters)
    letters = case type
              when :upper_case then UPPER_CASE_LETTERS
              when :lower_case then LOWER_CASE_LETTERS
              when :number     then NUMBER_LETTERS
              else fail 'type は :upper_case, :lower_case, :number のいずれかにしてください。'
              end
    letters = letters - CONFUSING_LETTERS if exclude_confusing_letters
    letters.sample
  end
end
