require "spec_helper"

describe Household do
  let(:household){ FactoryGirl.create(:household) }

  describe "#applicable_years" do
    it "should return an array of years" do
      Timecop.freeze("2014-02-03") do
        expect(household.applicable_years).to eq([2014, 2013, 2012, 2011])
      end
    end
  end

  describe "#recent" do
    it "should return the most recent entry" do
      FactoryGirl.create(:entry, household: household)
      FactoryGirl.create(:entry, household: household)
      last = FactoryGirl.create(:entry, household: household)
      expect(last.household.recent_entry).to eq(last)
    end

    it "should deal with an empty list" do
      expect(household.recent_entry).to be_nil
    end
  end

end
