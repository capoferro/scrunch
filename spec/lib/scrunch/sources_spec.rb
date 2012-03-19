require 'spec_helper'

module Scrunch
  describe Sources do
    subject { Sources.new }

    describe '#damage_total' do
      it 'should total up the damage values' do
        Source.any_instance.stub(:damage_total).and_return 1
        a = Source.new 'a'
        b = Source.new 'b'
        subject['a'] = a
        subject['b'] = b
        subject.damage_total.should == 2
      end
    end

    describe '#healing_total' do
      it 'should total up the healing values' do
        Source.any_instance.stub(:healing_total).and_return 1
        a = Source.new 'a'
        b = Source.new 'b'
        subject['a'] = a
        subject['b'] = b
        subject.healing_total.should == 2
      end
    end
  end
end
