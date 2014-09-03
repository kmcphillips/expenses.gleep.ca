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
end
