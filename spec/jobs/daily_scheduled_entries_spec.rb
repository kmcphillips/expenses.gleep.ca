require "spec_helper"

describe DailyScheduledEntries do
  let(:date){ Date.new(2011, 1, 1) }
  let(:household){ FactoryGirl.create(:household) }
  let(:category){ FactoryGirl.create(:category, household: household) }

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
      expect(Household).to receive(:all).and_return([household])
      expect(DailyScheduledEntries.new.households).to eq([household])
    end
  end

  describe "#run" do
    let(:job){ DailyScheduledEntries.new household: household, date: date }
    let(:active_entry_schedules){ [mortgage, insurance] }
    let(:mortgage){ FactoryGirl.create(:entry_schedule, category: category, household: household, name: "Mortgage", starts_on: date) }
    let(:insurance){ FactoryGirl.create(:entry_schedule, category: category, household: household, name: "Insurance", starts_on: (date + 2.days)) }
    let(:inative_entry_schedule){ FactoryGirl.create(:entry_schedule, category: category, household: household, active: false) }
    let(:another_household_entry_schedule){ FactoryGirl.create(:entry_schedule, category: category, household: FactoryGirl.create(:household), active: false) }

    before(:each) do
      # pre-create objects
      active_entry_schedules
      inative_entry_schedule
      another_household_entry_schedule
    end

    it "should build and save entries" do
      expect{ job.run }.to change{ Entry.unique.count }.from(0).to(1)
    end

    it "should trigger creation of amortized entries" do
      expect{ job.run }.to change{ AmortizedEntry.count }
    end

    context "attributes" do
      before(:each) do
        job.run
      end

      subject{ Entry.unique.first }

      describe '#entry_schedule' do
        subject { super().entry_schedule }
        it { is_expected.to eq(mortgage) }
      end

      describe '#incurred_on' do
        subject { super().incurred_on }
        it { is_expected.to eq(date) }
      end
    end
  end
end
