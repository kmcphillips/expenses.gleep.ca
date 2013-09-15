require "spec_helper"

describe User do
  
  describe "#authorized?" do
    let(:authorized_email){ FactoryGirl.create(:authorized_email) }

    it "should return the first authorized email for the household" do
      expect(User.new(email: authorized_email.email).authorized?).to be_true
    end

    it "should not be true if no email is found" do
      expect(User.new(email: "fake@asdf.com").authorized?).to be_false
    end
  end
end
