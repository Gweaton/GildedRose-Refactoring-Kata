class GildedRose
  SPECIAL_ITEMS = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"]
  MINIMUM_QUALITY = 0
  MAXIMUM_QUALITY = 50
  CONJURED_DEGRADATION_RATE = 2

  def initialize(items)
    @items = items
  end

  def update_values()
    @items.each do |item|
      update_normal_item(item) if is_normal?(item)
      update_conjured_item(item, CONJURED_DEGRADATION_RATE) if conjured?(item)
      update_exceptions(item)
    end
  end

  private

  def decrease_sell_in_date(item)
    item.sell_in -= 1
  end

  def increase_quality(item, amount = 1)
    item.quality += amount if item.quality < MAXIMUM_QUALITY
  end

  def decrease_normal_item_quality(item, rate = 1)
    return (item.quality -= 2 * rate) if out_of_date?(item) unless item.quality <= MINIMUM_QUALITY + 1
    item.quality -= (1 * rate) unless item.quality == MINIMUM_QUALITY
  end

  def update_conjured_item(item, rate)
    decrease_normal_item_quality(item, rate)
    decrease_sell_in_date(item)
  end

  def update_special(item, amount = 1)
    increase_quality(item, amount)
    decrease_sell_in_date(item)
  end

  def update_exceptions(item)
    update_special(item) if item.name == "Aged Brie"
    update_backstage_passes(item) if item.name.include? "Backstage passes"
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

  def conjured?(item)
    item.name.include? "Conjured"
  end

  def is_normal?(item)
    !(SPECIAL_ITEMS.include? item.name) && !(conjured?(item))
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
