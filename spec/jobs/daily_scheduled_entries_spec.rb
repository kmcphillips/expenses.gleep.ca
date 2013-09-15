require "spec_helper"

describe DailyScheduledEntries do
  let(:date){ Date.new(2011, 1, 1) }
  let(:household){ FactoryGirl.create(:household) }

  describe "#initialize" do
    it "should default to today's date" do
      expect(DailyScheduledEntries.new.date).to eq(Date.today)
    end

    it "should allow an override date" do
      expect(DailyScheduledEntries.new(date: date).date).to eq(date)
    end

    it "should let you specify a household" do
      expect(DailyScheduledEntries.new(household: household).households).to eq([household])
    end

    it "should let you specify a list of households" do
      expect(DailyScheduledEntries.new(households: [household]).households).to eq([household])
    end

    it "should default to all households" do
      Household.should_receive(:all).and_return([household])
      expect(DailyScheduledEntries.new.households).to eq([household])
    end
  end

  describe "#run" do
    let(:job){ DailyScheduledEntries.new household: household, date: date }

  end
end
