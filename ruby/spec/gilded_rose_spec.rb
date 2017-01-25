require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do

    before do
    end

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "should reduce quality of normal items by 1 each time" do
      items = [Item.new("item", 2, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
    end

    it "should reduce quality of normal items by twice as much once sell_in date has passed" do
      items = [Item.new("item", 0, 4)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end
  end
end
