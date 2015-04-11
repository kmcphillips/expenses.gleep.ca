require "spec_helper"

describe ApplicationHelper do

  describe "#page_title" do
    it "should return a basic title" do
      expect(helper.page_title).to eq("Expenses")
    end
  end

  describe "#boolean_glyph" do
    it "should return an icon for true" do
      expect(helper.boolean_glyph(false)).to eq("<i class=\"fa fa-times text-warning\"></i>")
    end

    it "should reuturn an icon for false" do
      expect(helper.boolean_glyph(true)).to eq("<i class=\"fa fa-check text-success\"></i>")
    end
  end

end
