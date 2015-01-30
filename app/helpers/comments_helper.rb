module CommentsHelper

  def int_to_alphadecimal(i)
    n = i.to_s(36)
    return (n.length - 1).to_s << n
  end
  
  def alphadecimal_to_int(s)
    return s[1..-1].to_i(36)
  end

end
