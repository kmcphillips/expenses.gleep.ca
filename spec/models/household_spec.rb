require "spec_helper"

describe Household do
  let(:household){ FactoryGirl.create(:household) }

  describe "#applicable_years" do
    it "should return an array of years" do
      Timecop.freeze("2014-02-03") do
        expect(household.applicable_years).to eq([2011, 2012, 2013, 2014])
      end
    end
  end

end
