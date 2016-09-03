class SideBagItem < ApplicationRecord
  belongs_to :player
  audited associated_with: :player


  def self.possibilities
    [
      "Dynamite",
      "Bandages",
      "Whiskey",
      "Potion",
      "Lantern Oil",
      "Hatchet",
      "Spice",
      "Exotic Herbs",
      "Flask",
      "Tequila",
      "Swamp Fungus",
      "Herbs",
      "Tonic"
    ].sort
  end
end
