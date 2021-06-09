class Person
  attr_reader :name,
              :interests,
              :supplies

  def initialize(data)
    @name      = data[:name]
    @interests = data[:interests]
    @supplies  = Hash.new(0)
  end

  def add_supply(name, quantity)
    @supplies[name] += quantity
  end

  def can_build?(craft)
    craft.supplies_required.all? do |name, quantity|
      @supplies[name.to_s] >= craft.supplies_required[name] unless
        @supplies[name.to_s].nil?
    end
  end
end
