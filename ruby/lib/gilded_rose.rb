class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|

      return update_brie(item) if item.name == "Aged Brie"
      return update_backstage_passes(item) if item.name.include? "Backstage passes"



      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            decrease_normal_item_quality(item)
          end
        end
      else

      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        decrease_sell_in_date(item)
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                decrease_normal_item_quality(item)
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          increase_quality(item)
        end
      end
    end
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
    item.quality < 0 ? item.quality -= 2 : item.quality -= 1
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
