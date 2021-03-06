require "spec_helper"

describe User do
  
  describe "#authorized?" do
    let(:authorized_email){ FactoryGirl.create(:authorized_email) }

    it "should return the first authorized email for the household" do
      expect(User.new(email: authorized_email.email).authorized?).to be_truthy
    end

    it "should not be true if no email is found" do
      expect(User.new(email: "fake@asdf.com").authorized?).to be_falsey
    end
  end

  describe "#short_name" do
    it "should return the first name" do
      expect(FactoryGirl.build(:user).short_name).to eq("Spendy")
    end
  end
end
