# Extends String to include color display methods.
class String
  def bg_black
    "\e[40m#{self}\e[0m"
  end

  def bold
    "\e[1m#{self}\e[22m"
  end

  def italic
    "\e[3m#{self}\e[23m"
  end
end
