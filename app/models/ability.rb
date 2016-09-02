class Ability < ApplicationRecord
  belongs_to :player
  has_many :stat_mods, as: :modifiable
  accepts_nested_attributes_for :stat_mods, reject_if: :all_blank, allow_destroy: true
  audited associated_with: :player
  has_associated_audits

  def self.possibilities
    self.select(:name).distinct.map{|x| x.name}
  end
end
