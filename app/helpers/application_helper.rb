module ApplicationHelper
  
  def number_to_kanji(number)
    kanji = %w[〇 一 二 三 四 五 六 七 八 九 十]
    return kanji[number] if number <= 10

    if number < 20
      "十#{kanji[number % 10]}"
    elsif number < 100
      tens = number / 10
      ones = number % 10
      result = "#{kanji[tens]}十"
      result += kanji[ones] if ones != 0
      result
    else
      number.to_s
    end
  end
end
