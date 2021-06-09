class Craft
  attr_reader :name,
              :supplies_required

  def initialize(name, supplies_required)
    @name              = name
    @supplies_required = supplies_required
  end

  def num_supply_types
    @supplies_required.keys.length
  end

  def supply_list
    @supplies_required.keys.map { |key| key.to_s }
  end
end
