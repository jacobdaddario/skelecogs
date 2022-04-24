module Interactions
  def keyboard
    OpenStruct.new({
      enter: 13,
      escape: 27,
      space: 32,
      end: 35,
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
end
