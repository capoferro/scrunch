require 'spec_helper'

module Scrunch
  describe Cruncher do
    subject { described_class.new File.join logs_path, 'Ahri-vs-ForceGuardian.txt' }

    describe '#crunch' do
      it 'should crunch logs and return a hash of damage sources with their damage output' do
        subject.crunch.should == {"@Ahri"=>2825, "@Ahri:T7-O1"=>859, "Forge Guardian"=>3122}
      end

      it 'should not explode when reading a file with an invalid byte sequence' do
        c = described_class.new File.join logs_path, 'Ahri-PvP.txt'
        -> { c.crunch }.should_not raise_error
      end
    end
    describe '#parse' do
      describe 'a damage line' do
        before do
          @damage_line = '[03/18/2012 03:59:24] [@Ahri] [Forge Guardian {795067165966336}] [Force Leap {812105301229568}] [ApplyEffect {836045448945477}: Damage {836045448945501}] (73 energy {836045448940874}) <73>'
        end

        describe 'if the source does not exist prior to the line being parsed' do
          it 'should take a line and update the appropriate source with damage done' do
            subject.parse @damage_line
            subject.sources['@Ahri'].should == 73
          end
        end
        
        describe 'if the source exists prior to the line being parsed' do
          it 'should increment damage done' do
            2.times { subject.parse @damage_line }
            subject.sources['@Ahri'].should == 146
          end
        end
      end
      describe 'a non-damage line' do
        ['[03/18/2012 03:55:59] [@Ahri] [@Ahri] [Basic Might Stim {813333661876224}] [ApplyEffect {836045448945477}: Basic Might Stim {813333661876224}] ()', '[03/18/2012 03:56:05] [@Ahri] [@Ahri] [Safe Login {973870949466112}] [RemoveEffect {836045448945478}: Safe Login Immunity {973870949466372}] ()'].each do |line|
          it "#{line} should not explode" do
            -> {subject.parse line}.should_not raise_error
          end
        end
      end
    end
    describe '#parse_result' do
      before do
        @result = 'ApplyEffect {836045448945477}: Damage {836045448945501}] (73 energy {836045448940874}) <73>'
      end

      it 'should return a hash of the details of the result chunk' do
        subject.parse_result(@result).should == {effect: {damage: {amount: 73, type: 'energy'}}}
      end
    end

  end
end
