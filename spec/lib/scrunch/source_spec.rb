require 'spec_helper'

module Scrunch
  describe Source do
    subject { Source.new 'thesource' }
    
    describe '#add_effect_result' do
      it 'should increment damage when a damage effect result is provided' do
        subject.add_effect_result effect: {damage: {amount: 5, type: 'energy'}}
        subject.add_effect_result effect: {damage: {amount: 5, type: 'energy'}}
        subject.damage_total.should == 10
      end
      it 'should increment healing when a heal effect result is provided' do
        subject.add_effect_result effect: {heal: {amount: 5, type: 'energy'}}
        subject.add_effect_result effect: {heal: {amount: 5, type: 'energy'}}
        subject.healing_total.should == 10
      end
    end
  end
end
