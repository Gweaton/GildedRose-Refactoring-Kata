class GildedRose
  SPECIAL_ITEMS = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"]
  MINIMUM_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_values()
    @items.each do |item|
      update_normal_item(item) if !(SPECIAL_ITEMS.include? item.name)
      update_special(item) if item.name == "Aged Brie"
      update_backstage_passes(item) if item.name.include? "Backstage passes"
    end
  end

  private

  def decrease_sell_in_date(item)
    item.sell_in -= 1
  end

  def increase_quality(item, amount = 1)
    item.quality += amount if item.quality < 50
  end

  def decrease_normal_item_quality(item)
    return item.quality -= 2 if out_of_date?(item) unless item.quality <= MINIMUM_QUALITY + 1
    item.quality -= 1 unless item.quality == MINIMUM_QUALITY
  end

  def update_special(item, amount = 1)
    increase_quality(item, amount)
    decrease_sell_in_date(item)
  end

  def out_of_date?(item)
    item.sell_in <= 0
  end

  def update_backstage_passes(item)
    return item.quality = MINIMUM_QUALITY if out_of_date?(item)
    return update_special(item, 3) if item.sell_in <= 5
    return update_special(item, 2) if item.sell_in <= 10
    update_special(item)
  end

  def update_normal_item(item)
    decrease_sell_in_date(item)
    decrease_normal_item_quality(item)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
