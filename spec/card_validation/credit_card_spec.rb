require File.join(File.dirname(__FILE__), '..', 'spec_helper')

module CardValidation
  describe CreditCard do
    
    @LUHN_VALID = { "42" => "a simple number", 
                    "34" => "another simple number", 
                    "91" => "with digits that, when doubled, yield 2-digit numbers",
                    "4223747542628374" => ""}
    
    
    it 'can be instantiated with a number' do
      card = CreditCard.new("12345")
      
      card.number.should == "12345"
    end
    
    it "can be invalid" do
      card = CreditCard.new("01")
      
      card.should_not be_valid
    end

    @LUHN_VALID.each do |num, msg|
      it "should identify luhn validity of the number #{num} #{msg}" do
        card = CreditCard.new(num)
        
        card.should be_valid
      end
    end
    
    it "should identify luhn invalidity of the number " do
      card = CreditCard.new("4123747542628374")
      
      card.should_not be_valid
    end
    
    it "can receive a company name" do
      card = CreditCard.new(mock(String))
      
      mockompany = mock(Symbol)
      card.company = mockompany
      
      card.company.should == mockompany
    end
    
    context "from american express (AMEX)" do
      it "should identify a valid AMEX card" do
        card = CreditCard.new("340000000000009")
      
        card.company = :amex
      
        card.should be_valid
      end
    
      it "should identify an otherwise valid card that is not a valid AMEX card" do
        card = CreditCard.new("300000000000007")

        card.should be_valid
        card.company = :amex
            
        card.should_not be_valid
      end
    
      it "should identify a too-short AMEX card" do
        card = CreditCard.new("34000000000000")

        card.should be_valid
        card.company = :amex
            
        card.should_not be_valid
      end
    end
    
    context "from Mastercard" do
      it "should identify a valid mastercard" do
        card = CreditCard.new("5300000000000006")
      
        card.company = :mastercard
      
        card.should be_valid
      end
    
      it "should identify an otherwise valid card that is not a valid mastercard" do
        card = CreditCard.new("1300000000000005")

        card.should be_valid
        card.company = :mastercard
            
        card.should_not be_valid
      end
    
      it "should identify a too-short mastercard" do
        card = CreditCard.new("530000000000009")

        card.should be_valid
        card.company = :mastercard
            
        card.should_not be_valid
      end
    end
    
    context "from visa" do
      it "should identify a valid visa with 13 chars" do
        card = CreditCard.new("4000000000006")
      
        card.company = :visa
      
        card.should be_valid
      end
      
      it "should identify a valid visa with 16 chars" do
        card = CreditCard.new("4000000000000002")

        card.company = :visa

        card.should be_valid
      end
    
      it "should identify an otherwise valid card that is not a valid visa" do
        card = CreditCard.new("2000000000000006")

        card.should be_valid
        card.company = :visa
            
        card.should_not be_valid
      end
    
      it "should identify an incorrect length visa" do
        card = CreditCard.new("40000000000002")

        card.should be_valid
        card.company = :visa
            
        card.should_not be_valid
      end
    end
    
    context "from discover" do
      it "should identify a valid discover card" do
        card = CreditCard.new("6011000000000004")

        card.company = :discover
        
        card.should be_valid
      end

      it "should identify an otherwise valid card that is not a valid discover card" do
        card = CreditCard.new("2000000000000006")

        card.should be_valid
        card.company = :discover

        card.should_not be_valid
      end

      it "should identify an incorrect length discover card" do
        card = CreditCard.new("601100000000001")

        card.should be_valid
        card.company = :discover

        card.should_not be_valid
      end
    end
    
  end
end

