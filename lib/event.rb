class Event
  attr_reader :name,
              :crafts,
              :attendees

  def initialize(name, crafts, attendees)
    @name      = name
    @crafts    = crafts
    @attendees = attendees
  end

  def attendee_names
    @attendees.map { |attendee| attendee.name }
  end

  def craft_with_most_supplies
    @crafts.max_by { |craft| craft.num_supply_types }.name
  end

  def supply_list
    @crafts.flat_map { |craft| craft.supply_list }.uniq
  end

  def find_craft_by_name(name)
    @crafts.find { |craft| craft.name == name }
  end

  def attendees_by_craft_interest
    @crafts.reduce({}) do |hash, craft|
      hash.update( craft.name => []) if hash[craft.name].nil?
      hash[craft.name] << @attendees.find_all do |attendee|
        attendee.interests.include?(craft.name)
      end
      hash.transform_values do |values|
        values.flatten
      end
    end
  end

  def crafts_that_use(supply)
    @crafts.each_with_object([]) do |craft, array|
      array << craft if craft.supply_list.include?(supply)
    end
  end

  def craft_hash
    @crafts.each_with_object({}) do |craft, hash|
      hash[craft] = []
    end
  end

  def assign_attendees
    @attendees.group_by do |attendee|
      random_interest = nil
      until find_craft_by_name(random_interest) != nil
        random_interest = attendee.interests.sample
      end
      find_craft_by_name(random_interest)
    end
  end

  def assign_attendees_to_crafts
    assign_attendees.update(craft_hash) do |key, oldv, newv|
      oldv unless oldv == nil
    end
  end
end
