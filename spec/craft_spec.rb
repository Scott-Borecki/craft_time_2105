require './lib/person'
require './lib/craft'
require './lib/event'

RSpec.describe Craft do
  describe 'Object Creation' do
    before :each do
      @craft = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    end

    it 'exists' do
      expect(@craft).to be_an_instance_of(Craft)
    end

    it 'has readable attributes' do
      expect(@craft.name).to eq('knitting')
      expect(@craft.supplies_required).to eq({yarn: 20, scissors: 1, knitting_needles: 2})
    end
  end

  describe 'Object Methods' do
    before :each do
      @craft = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    end

    it 'can return number of supply types for craft' do
      actual   = @craft.num_supply_types
      expected = 3
      expect(actual).to eq(expected)
    end

    it 'can return a list of supplies' do
      actual   = @craft.supply_list
      expected = ['yarn', 'scissors', 'knitting_needles']
      expect(actual).to eq(expected)
    end
  end
end
