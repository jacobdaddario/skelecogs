module Interactions
  # I have to do this because Cuprite clicks things before trying
  # to send keys...
  def button_safe_send_keys(button, key)
    button.click
    button.send_keys key
  end
end
