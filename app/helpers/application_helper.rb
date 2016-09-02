module ApplicationHelper

  def difference_verb value
    return "changed to" if !value.is_a? Array

    if value[0] < value[1]
      "increased to"
    else
      "decreased to"
    end
  end

  def difference_color value
    return "#ecf0f1" if !value.is_a? Array

    if value[0] < value[1]
      "#2ecc71"
    else
      "#c0392b"
    end
  end

  def current_value val
    return val unless val.is_a? Array
    val[val.length - 1]
  end
end
