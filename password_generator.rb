# frozen_string_literal: true

require "optparse"

class PasswordGenerator
  class BadPasswordError < StandardError; end

  UPPER_CASE_LETTERS = [*'A'..'Z'].freeze
  LOWER_CASE_LETTERS = [*'a'..'z'].freeze
  NUMBER_LETTERS     = [*'0'..'9'].freeze
  CONFUSING_LETTERS  = ['O', '0', 'I', 'l', '1'].freeze

  attr_reader :length, :exclude_confusing_letters

  def initialize(length: 8, exclude_confusing_letters: false)
    fail BadPasswordError, 'パスワードは8文字以上にしてください' if length < 8

    @length = length
    @exclude_confusing_letters = exclude_confusing_letters
  end

  def generate
    password_array = []
    password_array << get_random_letter(:upper_case)
    password_array << get_random_letter(:lower_case)
    password_array << get_random_letter(:number)

    (length - password_array.size).times do
      type = [:upper_case, :lower_case, :number].sample
      password_array << get_random_letter(type)
    end

    password_array.shuffle.join
  end

  private

  def get_random_letter(type)
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

options = {}
opts = OptionParser.new
opts.on('-l', '--length LENGTH', '生成するパスワードの長さを指定します。') do |length|
  options[:length] = length.to_i
end
opts.on('--exclude_confusing_letters', '紛らわしい文字を除いてパスワードを生成します。') do
  options[:exclude_confusing_letters] = true
end
opts.parse!(ARGV)

pg = PasswordGenerator.new(options)
puts "Your password: #{pg.generate}"
