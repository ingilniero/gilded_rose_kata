module CommonItem
  def lower_quality
    self.quality -= 1
  end

  def lower_sell_in
    self.sell_in -= 1
  end

  def can_lower_quality?
    self.quality > 0
  end

  def sell_date_passed?
    self.sell_in <= 0
  end

  def change_quality
    lower_quality if can_lower_quality?
    lower_quality_again if can_lower_quality?
  end

  def lower_quality_again
    lower_quality if sell_date_passed?
  end

  def update_quality
    change_quality
    lower_sell_in
  end
end

module NormalItem
  include CommonItem
end

module AgedBrie
  include CommonItem

  def can_raise_quality?
    self.quality < 50
  end

  def raise_quality
    self.quality += 1
  end

  def change_quality
    raise_quality if can_raise_quality?
    raise_quality_again if can_raise_quality?
  end

  def raise_quality_again
    raise_quality if sell_date_passed?
  end
end

module Sulfuras
  include CommonItem

  def can_lower_quality?
    false
  end

  def sell_date_passed?
    false
  end

  def lower_sell_in
    self.sell_in
  end
end

module BackstagePass
  include CommonItem

  def can_raise_quality?
    self.quality < 50
  end

  def raise_quality
    case
      when sell_in > 5 && sell_in < 11 then self.quality += 2
      when sell_in < 6 && sell_in > 0 then self.quality += 3
      when sell_in <= 0 then self.quality = 0
      else self.quality += 1
    end
  end

  def change_quality
    raise_quality if can_raise_quality?
  end
end

module Conjured
  include CommonItem

  def lower_quality
    self.quality -= 2
  end

  def change_quality
    lower_quality if can_lower_quality?
  end
end
