class GildedRose
  SPECIAL_ITEMS = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"]

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_normal_item(item) if !(SPECIAL_ITEMS.include? item.name)
      update_brie(item) if item.name == "Aged Brie"
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
    item.sell_in < 0 ? item.quality -= 2 : item.quality -= 1 unless item.quality == 0
  end

  def update_brie(item)
    increase_quality(item)
    decrease_sell_in_date(item)
  end

  def update_backstage_passes(item)
    if item.sell_in <= 0
      item.quality = 0
    elsif item.sell_in <= 5
      increase_quality(item, 3)
      decrease_sell_in_date(item)
    elsif item.sell_in <= 10
      increase_quality(item, 2)
      decrease_sell_in_date(item)
    else
      increase_quality(item)
      decrease_sell_in_date(item)
    end
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
