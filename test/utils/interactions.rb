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
      downArrow: 40,
      a: 65,
      b: 66,
      c: 67,
      d: 68,
      e: 69,
      f: 70,
      g: 71,
      h: 72,
      i: 73,
      j: 74,
      k: 75,
      l: 76,
      m: 77,
      n: 78,
      o: 79,
      p: 80,
      q: 81,
      r: 82,
      s: 83,
      t: 84,
      u: 85,
      v: 86,
      w: 87,
      x: 88,
      y: 89,
      z: 90
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
      # This is so hacky, but oh well. We can improve JS testing in Ruby some other time
      char = "space" if char == " "

      elem.evaluate_script("this.dispatchEvent(new KeyboardEvent('keydown', {keyCode: #{keyboard.send(char.downcase)}, key: '#{char}', bubbles: true}))")
    end

    # This is the reset time for search terms. Important for testing the typing
    sleep(0.35)
  end
end
