require 'spec_helper'

describe EntrySchedule do
  let(:user){ FactoryGirl.create(:user) }
  let(:household){ user.household }
  let(:category){ FactoryGirl.create(:category, household: household) }
  let(:params){ {name: "Name", category: category, household: household, amount: 12, frequency: 'monthly', starts_on: date} }
  let(:date){ "2012-01-01" }

  describe "#applies_today?" do
    let(:entry_schedule){ EntrySchedule.new params.merge(starts_on: Date.today) }

    it "should return false if it is not active" do
      entry_schedule.active = false
      expect(entry_schedule.applies_today?).to be_false
    end

    it "should return true if the current period starts today" do
      entry_schedule.should_receive(:current_period).and_return(Date.today...(Date.today + 2.days))
      expect(entry_schedule.applies_today?).to be_true
    end

    it "should return true if the current period does not start today" do
      entry_schedule.should_receive(:current_period).and_return((Date.today - 2.days)...(Date.today + 2.days))
      expect(entry_schedule.applies_today?).to be_false
    end
  end

  describe "#current_period" do
    let(:entry_schedule){ EntrySchedule.new params }

    it "should return the period_for today" do
      result = double
      entry_schedule.should_receive(:period_for).with(Date.today).and_return(result)
      expect(entry_schedule.current_period).to equal(result)
    end
  end

end
