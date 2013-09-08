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

    it "should return true for yearly if it matches today, but not tomorrow" do
      entry_schedule.frequency = 'yearly'
      expect(entry_schedule.applies_today?).to be_true
      entry_schedule.starts_on = Date.today + 1
      expect(entry_schedule.applies_today?).to be_false
    end

    it "should return true for monthly if it matches today and a month from today, but not tomorrow" do
      pending
      entry_schedule.frequency = 'monthly'
      expect(entry_schedule.applies_today?).to be_true
      entry_schedule.starts_on = Date.today + 1.month
      expect(entry_schedule.applies_today?).to be_false
    end
  end

end
