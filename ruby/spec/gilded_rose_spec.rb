require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do

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

    it "should never set quality to a negative value" do
      items = [Item.new("item", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).not_to be < 0
    end

    context 'special items' do

      it "should increase the quality for 'Aged Brie' time update quality is run" do
        items = [Item.new("Aged Brie", 5, 5)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 6
      end

      it "should not set quality above 50" do
        items = [Item.new("Aged Brie", 0, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "should not change the quality of a legendary item" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      context 'backstage passes' do
        it "should increase in quality as it gets closer to the sell_in date" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 2)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 3
        end
      end
    end

    context 'sell_in date' do
      it "should reduce sell_in date of normal items by 1 each time" do
        items = [Item.new("item", 2, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 1
      end
    end

  end
end
