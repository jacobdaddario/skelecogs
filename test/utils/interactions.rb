module Interactions
  def keyboard
    OpenStruct.new({
      enter: 13,
      escape: 27,
      space: 32,
      pageUp: 33,
      pageDown: 34,
      end: 35,
      home: 36,
      upArrow: 38,
      downArrow: 40
    })
  end

  # I have to do this because Cuprite clicks things before trying
  # to send keys...
  def button_safe_send_keys(elem, key)
    elem.evaluate_script("this.focus()")
    elem.evaluate_script("this.dispatchEvent(new KeyboardEvent('keydown', {keyCode: #{key}, bubbles: true}))")
  end

  def type_word(elem, word)
    elem.evaluate_script("this.focus()")
    word.each_char do |char|
      elem.evaluate_script("this.dispatchEvent(new KeyboardEvent('keydown', {key: '#{char}', bubbles: true}))")
    end

    # This is the reset time for search terms. Important for testing the typing
    sleep(0.35)
  end
end
