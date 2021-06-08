require './lib/person'
require './lib/craft'
require './lib/event'

RSpec.describe Craft do
  describe 'Object Creation' do
    before :each do
      @person = Person.new({
        name: 'Hector',
        interests: ['sewing', 'millinery', 'drawing']
      })
      @craft = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
      @event = Event.new("Carla's Craft Connection", [@craft], [@person])
    end

    it 'exists' do
      expect(@event).to be_an_instance_of(Event)
    end

    it 'has readable attributes' do
      expect(@event.name).to eq("Carla's Craft Connection")
      expect(@event.crafts).to eq([@craft])
      expect(@event.attendees).to eq([@person])
    end
  end

  describe 'Object Methods' do
    before :each do
      @hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})
      @toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
      @sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1, sewing_needles: 1})
      @knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
      @event = Event.new("Carla's Craft Connection", [@sewing, @knitting], [@hector, @toni])
    end

    it 'can return attendee names' do
      actual   = @event.attendee_names
      expected = ["Hector", "Toni"]
      expect(actual).to eq(expected)
    end

    it 'can return the craft with most supplies' do
      actual   = @event.craft_with_most_supplies
      expected = 'sewing'
      expect(actual).to eq(expected)
    end

    it 'can return a list of supplies' do
      actual   = @event.supply_list
      expected = ["fabric", "scissors", "thread", "sewing_needles", "yarn", "knitting_needles"]
      expect(actual).to eq(expected)
    end
  end

  describe 'Iteration 3' do
    before :each do
      @hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})
      @toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
      @tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting']})

      @knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
      @sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1})
      @painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})

      @event = Event.new("Carla's Craft Connection", [@knitting, @painting, @sewing], [@hector, @toni, @tony])
    end

    it 'can return attendees by craft interest' do
      actual   = @event.attendees_by_craft_interest
      expected = {
        "knitting" => [@toni, @tony],
        "painting" => [],
        "sewing"   => [@hector, @toni]
      }
      expect(actual).to eq(expected)
    end

    it 'can return crafts that use a given supply' do
      actual = @event.crafts_that_use('scissors')
      expected = [@knitting, @sewing]
      expect(actual).to eq(expected)

      actual = @event.crafts_that_use('fire')
      expected = []
      expect(actual).to eq(expected)
    end
  end

  describe 'Iteration 4' do
    before :each do
      @hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing', 'painting']})
      @toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
      @tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting', 'painting']})

      @knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
      @sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1})
      @painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})

      @toni.add_supply('yarn', 30)
      @toni.add_supply('scissors', 2)
      @toni.add_supply('knitting_needles', 5)
      @toni.add_supply('fabric', 10)
      @toni.add_supply('scissors', 1)
      @toni.add_supply('thread', 2)
      @toni.add_supply('paint_brush', 10)
      @toni.add_supply('paints', 20)

      @tony.add_supply('yarn', 20)
      @tony.add_supply('scissors', 2)
      @tony.add_supply('knitting_needles', 2)

      @hector.add_supply('fabric', 5)
      @hector.add_supply('scissors', 1)
      @hector.add_supply('thread', 1)
      @hector.add_supply('canvas', 5)
      @hector.add_supply('paint_brush', 10)
      @hector.add_supply('paints', 20)

      @event = Event.new("Carla's Craft Connection", [@knitting, @painting, @sewing], [@hector, @toni, @tony])
    end

    it 'can find craft by string name' do
      actual = @event.find_craft_by_name('knitting')
      expected = @knitting
      expect(actual).to eq(expected)
    end

    it 'can assign attendees to crafts' do
      actual = @event.assign_attendees
      expect(actual).to be_an_instance_of(Hash)
      expect(actual.keys[0]).to be_an_instance_of(Craft)
      expect(actual.values[0][0]).to be_an_instance_of(Person)
    end

    it 'can assign attendees to crafts' do
      actual = @event.assign_attendees_to_crafts
      expect(actual).to be_an_instance_of(Hash)
      expect(actual.keys[0]).to be_an_instance_of(Craft)
      expect(actual.values[0][0]).to be_an_instance_of(Person)
    end

    it 'can create hash of crafts with empty values' do
      actual   = @event.craft_hash
      expected = {
        @knitting => [],
        @sewing   => [],
        @painting => []
      }
      expect(actual).to eq(expected)
    end

  end
end
