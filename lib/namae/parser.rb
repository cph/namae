#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'singleton'
require 'strscan'

module Namae
  class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 97)

  include Singleton

  attr_reader :options, :input

  def initialize
    @input, @options = StringScanner.new(''), {
      :debug => false,
      :prefer_comma_as_separator => false,
      :comma => ',',
      :separator => /\s*(\band\b|\&)\s*/i,
      :title => /\s*\b(sir|lord|count(ess)?|(prof|dr|md|ph\.?d)\.?)(\s+|$)/i,
      :suffix => /\s*\b(JR|Jr|jr|SR|Sr|sr|[IVX]{2,})(\.|\b)/,
      :appellation => /\s*\b((mrs?|ms|fr|hr)\.?|miss|herr|frau)(\s+|$)/i
    }
  end

  def debug?
    options[:debug] || ENV['DEBUG']
  end

  def separator
    options[:separator]
  end

  def comma
    options[:comma]
  end

  def title
    options[:title]
  end

  def suffix
    options[:suffix]
  end

  def appellation
    options[:appellation]
  end

  def prefer_comma_as_separator?
    options[:prefer_comma_as_separator]
  end

  def parse(input)
    parse!(input)
  rescue => e
    warn e.message if debug?
    []
  end

  def parse!(string)
    input.string = normalize(string)
    reset
    do_parse
  end

  def normalize(string)
    string = string.strip
    string
  end

  def reset
    @commas, @words, @initials, @suffices, @yydebug = 0, 0, 0, 0, debug?
    self
  end

  private

  def stack
    @vstack || @racc_vstack || []
  end

  def last_token
    stack[-1]
  end

  def consume_separator
    return next_token if seen_separator?
    @commas, @words, @initials, @suffices = 0, 0, 0, 0
    [:AND, :AND]
  end

  def consume_comma
    @commas += 1
    [:COMMA, :COMMA]
  end

  def consume_word(type, word)
    @words += 1

    case type
    when :UWORD
      @initials += 1 if word =~ /^\s*[[:alpha:]]\.\s*$/
    when :SUFFIX
      @suffices += 1
    end

    [type, word]
  end

  def seen_separator?
    !stack.empty? && last_token == :AND
  end

  def suffix?
    !@suffices.zero? || will_see_suffix?
  end

  def will_see_suffix?
    input.peek(8).to_s.strip.split(/\s+/)[0] =~ suffix
  end

  def will_see_initial?
    input.peek(6).to_s.strip.split(/\s+/)[0] =~ /[[:alpha:]]\./
  end

  def seen_full_name?
    prefer_comma_as_separator? && @words > 1 &&
      (@initials > 0 || !will_see_initial?) && !will_see_suffix?
  end

  def next_token
    case
    when input.nil?, input.eos?
      nil
    when input.scan(separator)
      consume_separator
    when input.scan(/\s*,\s*/)
      if @commas.zero? && !seen_full_name? || @commas == 1 && suffix?
        consume_comma
      else
        consume_separator
      end
    when input.scan(/\s+/)
      next_token
    when input.scan(title)
      consume_word(:TITLE, input.matched.strip)
    when input.scan(suffix)
      consume_word(:SUFFIX, input.matched.strip)
    when input.scan(appellation)
      [:APPELLATION, input.matched.strip]
    when input.scan(/((\\\w+)?\{[^\}]*\})*[[:upper:]][^\s#{comma}]*/)
      consume_word(:UWORD, input.matched)
    when input.scan(/((\\\w+)?\{[^\}]*\})*[[:lower:]][^\s#{comma}]*/)
      consume_word(:LWORD, input.matched)
    when input.scan(/(\\\w+)?\{[^\}]*\}[^\s#{comma}]*/)
      consume_word(:PWORD, input.matched)
    when input.scan(/('[^'\n]+')|("[^"\n]+")/)
      consume_word(:NICK, input.matched[1...-1])
    else
      raise ArgumentError,
        "Failed to parse name #{input.string.inspect}: unmatched data at offset #{input.pos}"
    end
  end

  def on_error(tid, value, stack)
    raise ArgumentError,
      "Failed to parse name: unexpected '#{value}' at #{stack.inspect}"
  end

# -*- racc -*-
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
   -36,   -38,   -37,    58,    30,    62,    31,   -36,   -38,   -37,
   -36,   -38,   -37,    56,   -22,    56,   -22,    53,    52,    54,
   -36,   -22,   -22,   -22,    39,    16,    39,   -36,    33,    39,
   -22,    32,    17,    53,    52,    54,    53,    52,    54,    56,
    39,    45,   nil,    39,    14,    12,    15,   nil,   nil,     7,
     8,    14,    12,    15,   nil,   nil,     7,     8,    14,    22,
    15,    24,    60,    53,    52,    54,    14,    22,    15,    24,
    30,    46,    31,    53,    52,    54,    30,    28,    31,    30,
    28,    31,    30,    42,    31,    30,    28,    31,    30,    28,
    31,    30,    28,    31,    14,    22,    15,    53,    52,    54 ]

racc_action_check = [
    22,    15,    14,    44,    43,    50,    43,    22,    15,    14,
    22,    15,    14,    50,    28,    38,    28,    32,    32,    32,
    12,    28,    12,    42,    32,     1,    23,    12,    16,    60,
    42,    11,     1,    58,    58,    58,    45,    45,    45,    64,
    58,    27,   nil,    45,     0,     0,     0,   nil,   nil,     0,
     0,    17,    17,    17,   nil,   nil,    17,    17,    20,    20,
    20,    20,    49,    49,    49,    49,     9,     9,     9,     9,
    29,    29,    29,    62,    62,    62,    10,    10,    10,    25,
    25,    25,    24,    24,    24,    35,    35,    35,    21,    21,
    21,    41,    41,    41,     5,     5,     5,    65,    65,    65 ]

racc_action_pointer = [
    41,    25,   nil,   nil,   nil,    91,   nil,   nil,   nil,    63,
    73,    29,    20,   nil,     2,     1,    28,    48,   nil,   nil,
    55,    85,     0,    16,    79,    76,   nil,    39,    14,    67,
   nil,   nil,    14,   nil,   nil,    82,   nil,   nil,     5,   nil,
   nil,    88,    23,     1,     1,    33,   nil,   nil,   nil,    60,
     3,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    30,   nil,
    19,   nil,    70,   nil,    29,    94 ]

racc_action_default = [
    -1,   -43,    -2,    -4,    -5,   -43,    -8,    -9,   -10,   -23,
   -43,   -43,   -19,   -28,   -30,   -31,   -43,   -43,    -6,    -7,
   -43,   -43,   -19,   -39,   -43,   -43,   -29,   -15,   -20,   -23,
   -30,   -31,   -34,    66,    -3,   -43,   -15,   -11,   -40,   -41,
   -12,   -43,   -19,   -23,   -14,   -34,   -21,   -16,   -24,   -35,
   -26,   -32,   -36,   -37,   -38,   -14,   -42,   -13,   -34,   -17,
   -43,   -33,   -43,   -18,   -25,   -27 ]

racc_goto_table = [
     3,    38,    26,    65,    27,    18,     9,     2,    47,    23,
    37,    20,    21,    26,    19,    36,    25,     3,    40,    44,
    23,    59,    26,     9,    34,     1,   nil,    35,   nil,    55,
    43,    41,   nil,   nil,    63,    57,    26,   nil,    64,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    61,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,    61 ]

racc_goto_check = [
     3,    14,    15,    13,     9,     3,     7,     2,    11,     3,
     8,     7,    10,    15,     4,     9,    10,     3,     9,     9,
     3,    11,    15,     7,     2,     1,   nil,    10,   nil,     9,
     7,    10,   nil,   nil,    11,     9,    15,   nil,    14,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     3,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,     3 ]

racc_goto_pointer = [
   nil,    25,     7,     0,     9,   nil,   nil,     6,   -13,    -6,
     7,   -24,   nil,   -59,   -22,    -7 ]

racc_goto_default = [
   nil,   nil,   nil,    51,     4,     5,     6,    29,   nil,    11,
    10,   nil,    48,    49,    50,    13 ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 12, :_reduce_1,
  1, 12, :_reduce_2,
  3, 12, :_reduce_3,
  1, 13, :_reduce_4,
  1, 13, :_reduce_none,
  2, 13, :_reduce_6,
  2, 13, :_reduce_7,
  1, 13, :_reduce_none,
  1, 16, :_reduce_9,
  1, 16, :_reduce_10,
  3, 15, :_reduce_11,
  3, 15, :_reduce_12,
  4, 15, :_reduce_13,
  3, 15, :_reduce_14,
  2, 15, :_reduce_15,
  3, 17, :_reduce_16,
  4, 17, :_reduce_17,
  5, 17, :_reduce_18,
  1, 21, :_reduce_none,
  2, 21, :_reduce_20,
  3, 21, :_reduce_21,
  1, 20, :_reduce_none,
  1, 20, :_reduce_none,
  1, 22, :_reduce_24,
  3, 22, :_reduce_25,
  1, 22, :_reduce_26,
  3, 22, :_reduce_27,
  1, 18, :_reduce_none,
  2, 18, :_reduce_29,
  1, 26, :_reduce_none,
  1, 26, :_reduce_none,
  1, 24, :_reduce_none,
  2, 24, :_reduce_33,
  0, 23, :_reduce_none,
  1, 23, :_reduce_none,
  1, 14, :_reduce_none,
  1, 14, :_reduce_none,
  1, 14, :_reduce_none,
  0, 19, :_reduce_none,
  1, 19, :_reduce_none,
  1, 25, :_reduce_none,
  2, 25, :_reduce_42 ]

racc_reduce_n = 43

racc_shift_n = 66

racc_token_table = {
  false => 0,
  :error => 1,
  :COMMA => 2,
  :UWORD => 3,
  :LWORD => 4,
  :PWORD => 5,
  :NICK => 6,
  :AND => 7,
  :APPELLATION => 8,
  :TITLE => 9,
  :SUFFIX => 10 }

racc_nt_base = 11

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "COMMA",
  "UWORD",
  "LWORD",
  "PWORD",
  "NICK",
  "AND",
  "APPELLATION",
  "TITLE",
  "SUFFIX",
  "$start",
  "names",
  "name",
  "word",
  "display_order",
  "honorific",
  "sort_order",
  "u_words",
  "opt_suffices",
  "last",
  "von",
  "first",
  "opt_words",
  "words",
  "suffices",
  "u_word" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'parser.y', 10)
  def _reduce_1(val, _values, result)
     result = [] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 11)
  def _reduce_2(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 12)
  def _reduce_3(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 14)
  def _reduce_4(val, _values, result)
     result = Name.new(:given => val[0]) 
    result
  end
.,.,

# reduce 5 omitted

module_eval(<<'.,.,', 'parser.y', 16)
  def _reduce_6(val, _values, result)
     result = val[0].merge(:family => val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 17)
  def _reduce_7(val, _values, result)
     result = val[1].merge(val[0]) 
    result
  end
.,.,

# reduce 8 omitted

module_eval(<<'.,.,', 'parser.y', 20)
  def _reduce_9(val, _values, result)
     result = Name.new(:appellation => val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 21)
  def _reduce_10(val, _values, result)
     result = Name.new(:title => val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 25)
  def _reduce_11(val, _values, result)
             result = Name.new(:given => val[0], :family => val[1], :suffix => val[2])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 29)
  def _reduce_12(val, _values, result)
             result = Name.new(:given => val[0], :nick => val[1], :family => val[2])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 33)
  def _reduce_13(val, _values, result)
             result = Name.new(:given => val[0], :nick => val[1],
           :particle => val[2], :family => val[3])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 38)
  def _reduce_14(val, _values, result)
             result = Name.new(:given => val[0], :particle => val[1],
          :family => val[2])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 43)
  def _reduce_15(val, _values, result)
             result = Name.new(:particle => val[0], :family => val[1])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 48)
  def _reduce_16(val, _values, result)
             result = Name.new({ :family => val[0], :suffix => val[2][0],
           :given => val[2][1] }, !!val[2][0])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 53)
  def _reduce_17(val, _values, result)
             result = Name.new({ :particle => val[0], :family => val[1],
           :suffix => val[3][0], :given => val[3][1] }, !!val[3][0])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 58)
  def _reduce_18(val, _values, result)
             result = Name.new({ :particle => val[0,2].join(' '), :family => val[2],
           :suffix => val[4][0], :given => val[4][1] }, !!val[4][0])
       
    result
  end
.,.,

# reduce 19 omitted

module_eval(<<'.,.,', 'parser.y', 64)
  def _reduce_20(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 65)
  def _reduce_21(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 22 omitted

# reduce 23 omitted

module_eval(<<'.,.,', 'parser.y', 69)
  def _reduce_24(val, _values, result)
     result = [nil,val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 70)
  def _reduce_25(val, _values, result)
     result = [val[2],val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 71)
  def _reduce_26(val, _values, result)
     result = [val[0],nil] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 72)
  def _reduce_27(val, _values, result)
     result = [val[0],val[2]] 
    result
  end
.,.,

# reduce 28 omitted

module_eval(<<'.,.,', 'parser.y', 75)
  def _reduce_29(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 30 omitted

# reduce 31 omitted

# reduce 32 omitted

module_eval(<<'.,.,', 'parser.y', 80)
  def _reduce_33(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 34 omitted

# reduce 35 omitted

# reduce 36 omitted

# reduce 37 omitted

# reduce 38 omitted

# reduce 39 omitted

# reduce 40 omitted

# reduce 41 omitted

module_eval(<<'.,.,', 'parser.y', 89)
  def _reduce_42(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
end   # module Namae
