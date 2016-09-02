class Character < ApplicationRecord
  has_many :players

  def portrait
    "#{name.downcase.underscore}.png"
  end

end
