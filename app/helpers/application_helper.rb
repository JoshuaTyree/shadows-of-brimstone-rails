module ApplicationHelper

  def format_audit audit, &block
    block_content = capture &block if block_given?

    content = case audit[:type]
    when "create" then
      format_create_audit audit
    when "update" then
      format_update_audit audit
    when "destroy" then
      format_delete_audit audit
    end

    unless content.blank?
      content_tag(:li) do
        concat content_tag(:p, content.html_safe)
        concat block_content if block_content.present?
      end
    end
  end

  def format_update_audit audit
    content = ""
    changes = audit[:changes]
    prefix = "<span style='color: #e67e22'>#{@player.name}'s</span>"


    changes.each do |k,v|
      if v.is_a? Array
        prev = v[0]
        curr = v[1]
        diff = curr - prev
        verb = diff > 0 ? "increased by" : "decreased by"

        color = (diff > 0) ? "#1abc9c" : "#e74c3c"
        if k == "Wounds" or k == "Horror Wounds"
          color = "#e74c3c"
        end
        action = "<span style='color: #{color}'>#{k} #{verb} #{diff.abs} to #{curr}</span>"
        content += "#{prefix} #{action}<br/>"
      end
    end

    content
  end

  def format_create_audit audit
    model_type = audit[:model]
    prefix = "<span style='color: #e67e22'>#{@player.name}</span>"

    unless model_type == "Player"
      case model_type
      when "Ability" then
        "#{prefix} learned a new ability: <span style='color: #1abc9c'>#{audit[:object].name}</span>"
      when "StatMod" then
        amount = audit[:object].amount
        stat = audit[:object].stat_name.titleize
        verb = amount > 0 ? "gained" : "lost"
        color = amount > 0 ? "#1abc9c" : "#e74c3c"
        action = "<span style='color: #{color}'>#{verb} #{amount} #{stat}</span>"
        "#{prefix} permanently #{action}"
      when "Item" then
        name = audit[:changed]["Name"]
        "#{prefix} obtained a new <span style='color: #1abc9c'>#{name}</span>"
      when "SideBagItem" then
        name = audit[:changed]["Name"]
        "#{prefix} obtained a new <span style='color: #1abc9c'>#{name}</span>"
      end
    end
  end

  def format_delete_audit audit
    model_type = audit[:model]
    prefix = "<span style='color: #e67e22'>#{@player.name}</span>"
    case model_type
    when "Item" then
      "#{prefix} <span style='color: #e74c3c'>removed #{audit[:changed]["Name"]} from Inventory</span>"
    when "SideBagItem" then
      "#{prefix} <span style='color: #e74c3c'>removed #{audit[:changed]["Name"]} from Side Bag</span>"
    end
  end

  def action_verb audit
  end



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
