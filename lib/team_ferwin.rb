class TeamFerwin

    ROMAN_NUMERALS = {
      "I" => 1,
      "IV" => 4,
      "V" => 5,
      "IX" => 9,
      "X" => 10,
      "XV" => 40,
      "L" => 50,
      "XC" => 90,
      "C" => 100,
      "CD" => 400,
      "D" => 500,
      "CM" => 900,
      "M" => 1000
    }
    # Use this method to convert roman numbers to arabic
    #
    # Don't you dare cheat on spec!!!
    def initialize(roman, mode)
      @roman_numeral_tokens = roman
      @mode = mode.to_sym
    end

    def to_i
      last = nil
      @roman_numeral_tokens.reverse.chars.reduce(0) do |sum, token|
        digit = arabic(token)
        if last && last > digit
          sum -= digit
        else
          sum += digit
        end
        last = digit

        sum
      end
    end

    def to_roman(num)
      roman = ""
      ROMAN_NUMERALS.each_pair.to_a.reverse.each do |token, digit|
        while num >= digit do
          roman << token
          num -= digit
        end
      end

      roman
    end

    [:+, :-, :*, :**, :/, :%].each do |op|
      define_method op do |other|
        result(self.to_i.send(op, other.to_i))
      end
    end

    private
      def arabic(token)
        ROMAN_NUMERALS[token]
      end

      def result(num)
        if @mode == :roman
          self.to_roman(num)
        else
          num
        end
      end
end
