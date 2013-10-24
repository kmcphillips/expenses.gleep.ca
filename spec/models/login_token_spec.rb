require 'spec_helper'

describe LoginToken do
  let(:login_token){ FactoryGirl.build(:login_token) }

  describe "validations" do
    it "should be valid" do
      expect(login_token.save).to be_true
    end

    describe "#user_part_of_household" do
      it "should be invalid if the household is missing" do
        login_token.household = nil
        expect(login_token.valid?).to be_false
      end

      it "should be invalid if the user is missing" do
        login_token.user = nil
        expect(login_token.valid?).to be_false
      end

      it "should be invalid if the user is from a different household" do
        login_token.user = FactoryGirl.create(:user)
        expect(login_token.user.household).to_not eq(login_token.household)
        expect(login_token.valid?).to be_false
      end
    end
  end

  describe "#set_token" do
    it "should build a random token on validation" do
      expect(login_token.token).to be_blank
      login_token.valid?
      token = login_token.token
      expect(token).to match(/\A[a-f0-9]{32}\Z/)
      login_token.valid?
      login_token.save!
      expect(token).to eq(login_token.token)
    end
  end
end
