require 'spec_helper'

describe Entry do
  let(:entry){ FactoryGirl.create(:entry) }

  describe "#amortized_days" do

  end

  describe "#readable" do
    it "should build a readable string" do
      expect(entry.readable).to eq("$12 for a purchase by Spendy: Something")
    end
  end

  describe "#similar_to?" do
    let(:similar){ Entry.new(category: entry.category, amount: entry.amount, household: entry.household, description: "The similar one") }

    it "should be similar" do
      expect(entry).to be_similar_to(similar)
    end

    it "should not be similar" do
      similar.category = FactoryGirl.create(:category)
      expect(entry).to_not be_similar_to(similar)
    end

    it "should handle nil" do
      expect(entry).to_not be_similar_to(nil)
    end
  end
end
