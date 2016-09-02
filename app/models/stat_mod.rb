class StatMod < ApplicationRecord
  belongs_to :modifiable, polymorphic: true
  audited associated_with: :modifiable

  def self.possibilities
    self.select(:stat_name).distinct.map{|x| x.stat_name.gsub('_', ' ').titleize}
  end
end
