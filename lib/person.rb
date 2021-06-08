class Person
  attr_reader :name,
              :interests,
              :supplies

  def initialize(data)
    @name      = data[:name]
    @interests = data[:interests]
    @supplies  = {}
  end

  def add_supply(name, quantity)
    @supplies[name] = 0 if @supplies[name].nil?
    @supplies[name] += quantity
  end

  def can_build?(craft)
    craft.supplies_required.all? do |supply|
      @supplies[supply[0].to_s] >= craft.supplies_required[supply[0]] unless
        @supplies[supply[0].to_s].nil?
    end
  end
end
