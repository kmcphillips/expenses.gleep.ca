require 'spec_helper'

describe EntrySchedule do
  let(:user){ FactoryGirl.create(:user) }
  let(:household){ user.household }
  let(:category){ FactoryGirl.create(:category, household: household) }
  let(:params){ {name: "Name", category: category, household: household, amount: 12, frequency: 'monthly', starts_on: date} }
  let(:date){ "2012-01-01" }

  describe "validations" do
    context "starts_on" do
      it "should be valid with a date" do
        expect(EntrySchedule.new(params)).to be_valid
      end

      it "should be valid twice_monthly without a date" do
        expect(EntrySchedule.new(params.merge(frequency: 'twice_monthly', starts_on: nil))).to be_valid
      end

      it "should not be valid without a date" do
        expect(EntrySchedule.new(params.merge(starts_on: nil))).to_not be_valid
      end
    end
  end

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

  describe "#period_for" do
    context "monthly" do
      let(:es){ EntrySchedule.new params.merge(frequency: 'monthly', starts_on: Date.new(2012, 1, 12)) }
      let(:before_period){ Date.new(2013, 8, 12)..Date.new(2013, 9, 11) }
      let(:current_period){ Date.new(2013, 9, 12)..Date.new(2013, 10, 11) }
      let(:after_period){ Date.new(2013, 10, 12)..Date.new(2013, 11, 11) }

      it "should know the correct date range" do
        expect(es.period_for(Date.new(2013, 8, 12))).to eq(before_period)
        expect(es.period_for(Date.new(2013, 8, 20))).to eq(before_period)
        expect(es.period_for(Date.new(2013, 9, 2))).to eq(before_period)
        expect(es.period_for(Date.new(2013, 9, 11))).to eq(before_period)

        expect(es.period_for(Date.new(2013, 9, 12))).to eq(current_period)
        expect(es.period_for(Date.new(2013, 9, 30))).to eq(current_period)
        expect(es.period_for(Date.new(2013, 10, 1))).to eq(current_period)
        expect(es.period_for(Date.new(2013, 10, 11))).to eq(current_period)

        expect(es.period_for(Date.new(2013, 10, 12))).to eq(after_period)
        expect(es.period_for(Date.new(2013, 10, 26))).to eq(after_period)
        expect(es.period_for(Date.new(2013, 11, 1))).to eq(after_period)
        expect(es.period_for(Date.new(2013, 11, 11))).to eq(after_period)
      end

      it "should handle the end of month edge case closely enough" do
        jan31 = EntrySchedule.new(params.merge(
          frequency: 'monthly',
          starts_on: Date.new(2012, 1, 31)
        ))
        feb = Date.new(2013, 1, 31)..Date.new(2013, 2, 27)

        expect(jan31.period_for(Date.new(2013, 2, 1))).to eq(feb)
        expect(jan31.period_for(Date.new(2013, 2, 15))).to eq(feb)
      end

      it "should handle the beginning of month edge case" do
        may1 = EntrySchedule.new(params.merge(
          frequency: 'monthly',
          starts_on: Date.new(2012, 5, 1)
        ))
        may = Date.new(2013, 5, 1)..Date.new(2013, 5, 31)

        expect(may1.period_for(Date.new(2013, 5, 1))).to eq(may)
        expect(may1.period_for(Date.new(2013, 5, 21))).to eq(may)
        expect(may1.period_for(Date.new(2013, 5, 31))).to eq(may)
      end
    end

    context "twice_monthly" do
      let(:es){ EntrySchedule.new params.merge(frequency: 'twice_monthly') }
      let(:first_half){ Date.new(2013, 9, 1)..Date.new(2013, 9, 14) }
      let(:second_half){ Date.new(2013, 9, 15)..Date.new(2013, 9, 30) }

      it "should know the correct date range" do
        expect(es.period_for(Date.new(2013, 9, 1))).to eq(first_half)
        expect(es.period_for(Date.new(2013, 9, 10))).to eq(first_half)
        expect(es.period_for(Date.new(2013, 9, 14))).to eq(first_half)

        expect(es.period_for(Date.new(2013, 9, 15))).to eq(second_half)
        expect(es.period_for(Date.new(2013, 9, 20))).to eq(second_half)
        expect(es.period_for(Date.new(2013, 9, 30))).to eq(second_half)
      end
    end

    context "every_two_weeks" do
      let(:es){ EntrySchedule.new params.merge(frequency: 'every_two_weeks', starts_on: Date.new(2013, 1, 1)) }
      let(:wk1){ Date.new(2013, 1, 1)..Date.new(2013, 1, 14) }
      let(:wk2){ Date.new(2013, 1, 15)..Date.new(2013, 1, 28) }
      let(:wk3){ Date.new(2013, 1, 29)..Date.new(2013, 2, 11) }
      let(:wk4){ Date.new(2013, 2, 12)..Date.new(2013, 2, 25) }
      let(:wk5){ Date.new(2013, 2, 26)..Date.new(2013, 3, 11) }
      let(:wk6){ Date.new(2013, 3, 12)..Date.new(2013, 3, 25) }

      it "should know the correct date range" do
        expect(es.period_for(Date.new(2013, 1, 1))).to eq(wk1)
        expect(es.period_for(Date.new(2013, 1, 9))).to eq(wk1)
        expect(es.period_for(Date.new(2013, 1, 14))).to eq(wk1)
        
        expect(es.period_for(Date.new(2013, 1, 15))).to eq(wk2)
        expect(es.period_for(Date.new(2013, 1, 20))).to eq(wk2)
        expect(es.period_for(Date.new(2013, 1, 28))).to eq(wk2)
        
        expect(es.period_for(Date.new(2013, 1, 29))).to eq(wk3)
        expect(es.period_for(Date.new(2013, 2, 1))).to eq(wk3)
        expect(es.period_for(Date.new(2013, 2, 11))).to eq(wk3)
        
        expect(es.period_for(Date.new(2013, 2, 12))).to eq(wk4)
        expect(es.period_for(Date.new(2013, 2, 19))).to eq(wk4)
        expect(es.period_for(Date.new(2013, 2, 25))).to eq(wk4)
        
        expect(es.period_for(Date.new(2013, 2, 26))).to eq(wk5)
        expect(es.period_for(Date.new(2013, 3, 3))).to eq(wk5)
        expect(es.period_for(Date.new(2013, 3, 11))).to eq(wk5)
        
        expect(es.period_for(Date.new(2013, 3, 12))).to eq(wk6)
        expect(es.period_for(Date.new(2013, 3, 14))).to eq(wk6)
        expect(es.period_for(Date.new(2013, 3, 25))).to eq(wk6)
      end
    end

    context "quarterly" do
      let(:es){ EntrySchedule.new params.merge(frequency: 'quarterly', starts_on: Date.new(2012, 1, 1)) }
      let(:q1){ Date.new(2013, 1, 1)..Date.new(2013, 3, 31) }
      let(:q2){ Date.new(2013, 4, 1)..Date.new(2013, 6,30) }
      let(:q3){ Date.new(2013, 7, 1)..Date.new(2013, 9, 30) }
      let(:q4){ Date.new(2013, 10, 1)..Date.new(2013, 12, 31) }

      it "should know the correct date range" do
        expect(es.period_for(Date.new(2013, 1, 1))).to eq(q1)
        expect(es.period_for(Date.new(2013, 2, 12))).to eq(q1)
        expect(es.period_for(Date.new(2013, 3, 31))).to eq(q1)

        expect(es.period_for(Date.new(2013, 4, 1))).to eq(q2)
        expect(es.period_for(Date.new(2013, 5, 12))).to eq(q2)
        expect(es.period_for(Date.new(2013, 6, 30))).to eq(q2)

        expect(es.period_for(Date.new(2013, 7, 1))).to eq(q3)
        expect(es.period_for(Date.new(2013, 8, 12))).to eq(q3)
        expect(es.period_for(Date.new(2013, 9, 30))).to eq(q3)

        expect(es.period_for(Date.new(2013, 10, 1))).to eq(q4)
        expect(es.period_for(Date.new(2013, 11, 12))).to eq(q4)
        expect(es.period_for(Date.new(2013, 12, 31))).to eq(q4)
      end

      it "should catch the end of month edge cases" do
        mar31 = EntrySchedule.new params.merge(frequency: 'quarterly', starts_on: Date.new(2013, 3, 31))

        expect(mar31.period_for(Date.new(2013, 6, 29))).to eq(Date.new(2013, 3, 31)..Date.new(2013, 6, 29))
        expect(mar31.period_for(Date.new(2013, 6, 30))).to eq(Date.new(2013, 6, 30)..Date.new(2013, 9, 29))
      end
    end

    context "yearly" do
      let(:es){ EntrySchedule.new params.merge(frequency: 'yearly', starts_on: Date.new(2012, 4, 1)) }
      let(:period_2012){ Date.new(2012, 4, 1)..Date.new(2013, 3, 31) }
      let(:period_2013){ Date.new(2013, 4, 1)..Date.new(2014, 3, 31) }

      it "should know the correct date range" do
        expect(es.period_for(Date.new(2012, 4, 1))).to eq(period_2012)
        expect(es.period_for(Date.new(2012, 5, 11))).to eq(period_2012)
        expect(es.period_for(Date.new(2013, 2, 28))).to eq(period_2012)
        expect(es.period_for(Date.new(2013, 3, 31))).to eq(period_2012)

        expect(es.period_for(Date.new(2013, 4, 1))).to eq(period_2013)
        expect(es.period_for(Date.new(2013, 4, 11))).to eq(period_2013)
        expect(es.period_for(Date.new(2013, 12, 31))).to eq(period_2013)
        expect(es.period_for(Date.new(2014, 1, 14))).to eq(period_2013)
      end
    end
  end

end
