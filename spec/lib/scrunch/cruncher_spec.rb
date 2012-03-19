require 'spec_helper'

module Scrunch
  describe Cruncher do
    describe '::crunch(@filename)' do
      it 'should crunch(@filename) logs and return a hash of damage sources with their damage output' do
        sources = described_class.crunch(File.join logs_path, 'Ahri-vs-ForceGuardian.txt')
        sources['@Ahri'].damage_total.should == 2825
        sources['@Ahri:T7-O1'].damage_total.should == 859
        sources['Forge Guardian'].damage_total.should == 3122
      end

      it 'should not explode when reading a file with an invalid byte sequence' do
        -> { described_class.crunch File.join(logs_path, 'Ahri-PvP.txt')  }.should_not raise_error
      end
    end
    describe '::parse' do
      describe 'a damage line' do
        before do
          @damage_line = '[03/18/2012 03:59:24] [@Ahri] [Forge Guardian {795067165966336}] [Force Leap {812105301229568}] [ApplyEffect {836045448945477}: Damage {836045448945501}] (73 energy {836045448940874}) <73>'
        end

        it 'should take a line and parse it into source and effect result' do
          described_class.parse(@damage_line).should == ["@Ahri", "ApplyEffect {836045448945477}: Damage {836045448945501}] (73 energy {836045448940874}) <73>"]
        end
      end
      describe 'a non-damage line' do
        ['[03/18/2012 03:55:59] [@Ahri] [@Ahri] [Basic Might Stim {813333661876224}] [ApplyEffect {836045448945477}: Basic Might Stim {813333661876224}] ()', '[03/18/2012 03:56:05] [@Ahri] [@Ahri] [Safe Login {973870949466112}] [RemoveEffect {836045448945478}: Safe Login Immunity {973870949466372}] ()'].each do |line|
          it "#{line} should not explode" do
            -> {described_class.parse line}.should_not raise_error
          end
        end
      end
    end
    describe '::parse_effect_result' do
      before do
        @result = 'ApplyEffect {836045448945477}: Damage {836045448945501}] (73 energy {836045448940874}) <73>'
      end

      it 'should return a hash of the details of the result chunk' do
        described_class.parse_effect_result(@result).should == {effect: {damage: {amount: 73, type: 'energy'}}}
      end
    end

  end
end
