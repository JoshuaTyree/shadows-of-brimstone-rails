
class Player < ApplicationRecord
  audited
  has_associated_audits

  XP_CURVE = [
    500,
    1000,
    2000,
    3000,
    4500,
    6000,
    8000
  ]

  # Relationships
  belongs_to :character
  has_many :abilities
  has_many :items
  has_many :stat_mods, as: :modifiable
  has_many :side_bag_items

  validates :name, presence: true
  validates :xp, numericality: true
  validates :money, numericality: true
  validates :wounds, numericality: true
  validates :horror_wounds, numericality: true

  accepts_nested_attributes_for :abilities, :items

  def item_stat_changes
    _audits = []
    items.each do |item|
      item.associated_audits.each do |audit|
        _audits.push({
          object: audit.auditable,
          model: audit.auditable_type,
          type: audit.action,
          when: audit.created_at,
          changed: []
        })
      end
    end
    _audits
  end

  def ability_stat_changes
    _audits = []
    abilities.each do |item|
      item.associated_audits.each do |audit|
        _audits.push({
          object: audit.auditable,
          model: audit.auditable_type,
          type: audit.action,
          when: audit.created_at,
          changed: []
        })
      end
    end
    _audits
  end

  def changes
    # _audits = item_stat_changes
    # _audits = _audits.concat ability_stat_changes
    _audits = []

    associated_audits.each do |audit|
      final = {}
      items = audit.audited_changes.reject{|y,z| z.nil? or y == "character_id" or y == "id"}
      items.each do |k,v|
        tmp = k.gsub('_', ' ').titleize
        final[tmp] = v
      end

      _audits.push({
        object: audit.auditable,
        model: audit.auditable_type,
        type: audit.action,
        when: audit.created_at,
        changed: final
      })
    end

    audits.map{|x|
      final = {}
      items = x.audited_changes.reject{|y,z| z.nil? or y == "character_id" or y == "id"}
      items.each do |k,v|
        tmp = k.gsub('_', ' ').titleize
        final[tmp] = v
      end

      _audits.push({
        model: x.auditable_type,
        type: x.action,
        when: x.created_at,
        changes: final
      })
    }

    _audits.sort{|x,y| y[:when] <=> x[:when]}
  end



  def can_level_up?
    tnl <= 0 && !max_level?
  end

  def max_level?
    level > XP_CURVE.length
  end

  def tnl
    tnl = XP_CURVE[level - 1]
    return 0 if tnl.blank?
    tnl - xp
  end

  def levelup!
    unless !can_level_up?
      rm = XP_CURVE[level - 1]
      puts "Removing #{rm} XP"
      self.xp = xp - rm
      puts "New XP: #{xp}"
      self.level = level + 1
      puts "New Level: #{level}"
      self.save!
    end
  end


  def hp
    hp = stat_with_bonus :health
    "#{hp - wounds}/#{hp}"
  end

  def sanity
    sanity = stat_with_bonus(:sanity)
    "#{sanity - horror_wounds}/#{sanity}"
  end



  def stat_with_bonus stat_sym
    base_stat = character.send(stat_sym)
    base_stat ||= 0

    local_mods = stat_mods.where(stat_name: stat_sym.to_s).map{|x| x.amount}.reject{|y| y.nil?}
    local_mod_value = local_mods.reduce(:+)
    local_mod_value = 0 if local_mod_value.blank?
    base_stat += local_mod_value

    ability_mods = abilities.map{|x| x.stat_mods.where(stat_name: stat_sym.to_s).map{|y| y.amount}.reject{|z| z.nil?}}.flatten
    ability_mod_value = ability_mods.reduce(:+)
    ability_mod_value = 0 if ability_mod_value.blank?
    base_stat += ability_mod_value

    item_mods = items.where(equipped: true).map{|x| x.stat_mods.where(stat_name: stat_sym.to_s).map{|y| y.amount}.reject{|z| z.nil?}}.flatten
    item_mod_value = item_mods.reduce(:+)
    item_mod_value = 0 if item_mod_value.blank?
    base_stat += item_mod_value
    base_stat
  end

end
