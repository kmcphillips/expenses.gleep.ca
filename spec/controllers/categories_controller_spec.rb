require "spec_helper"

describe CategoriesController do
  let(:category){ FactoryGirl.create(:category) }

  before(:each) do
    login
  end

  describe "#index" do
    it "should be tested" do
      pending
    end
  end

end
