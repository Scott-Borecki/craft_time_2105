require './lib/person'
require './lib/craft'
require './lib/event'

RSpec.describe Person do
  describe 'Object Creation' do
    before :each do
      @person = Person.new({
        name: 'Hector',
        interests: ['sewing', 'millinery', 'drawing']
      })
    end

    it 'exists' do
      expect(@person).to be_an_instance_of(Person)
    end

    it 'has readable attributes' do
      expect(@person.name).to eq('Hector')
      expect(@person.interests).to eq(['sewing', 'millinery', 'drawing'])
      expect(@person.supplies).to eq({})
    end
  end

  describe 'Object Methods' do
    it 'can add supplies' do
      person = Person.new({
        name: 'Hector',
        interests: ['sewing', 'millinery', 'drawing']
      })

      person.add_supply('fabric', 4)
      person.add_supply('scissors', 1)

      actual   = person.supplies
      expected = {"fabric"=>4, "scissors"=>1}
      expect(actual).to eq(expected)

      person.add_supply('fabric', 3)

      actual   = person.supplies
      expected = {"fabric"=>7, "scissors"=>1}
      expect(actual).to eq(expected)
    end

    it 'can check if craft can be built with available supplies' do
      hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})
      toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
      sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1, sewing_needles: 1})
      knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})

      actual   = hector.can_build?(sewing)
      expected = false
      expect(actual).to eq(expected)

      hector.add_supply('fabric', 7)
      hector.add_supply('thread', 1)
      actual   = hector.can_build?(sewing)
      expected = false
      expect(actual).to eq(expected)

      hector.add_supply('scissors', 1)
      hector.add_supply('sewing_needles', 1)
      actual   = hector.can_build?(sewing)
      expected = true
      expect(actual).to eq(expected)
    end
  end
end
