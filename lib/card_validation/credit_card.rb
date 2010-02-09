module CardValidation
  class CreditCard
    attr_reader :number
    attr_accessor :company

    def initialize(number)
      @number = number
    end

    def valid?
      luhn_valid? && company_valid?
    end
    
    def company_valid?
      case @company
      when :amex 
        (@number.length == 15) && (@number.start_with?("34") || @number.start_with?("37"))
      when :discover
        (@number.length == 16) && (@number.start_with?("6011"))
      when :mastercard
        (@number.length == 16) && (@number[0,2].to_i > 50 && @number[0,2].to_i < 56)
      when :visa
        (@number.length == 16 || @number.length == 13) && (@number.start_with?("4"))
      else
        true
      end
    end
    
    def luhn_valid?
      sum = 0
      @number.reverse.split("").each_with_index do |num, i|
        if i % 2 == 0
          sum += num.to_i
        else
          sum += 2 * (num.to_i)
          sum -= 9 if num.to_i > 4
        end
      end
      
      (sum % 10) == 0
    end
    
  end
end

