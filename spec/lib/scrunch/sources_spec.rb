require 'spec_helper'

module Scrunch
  describe Sources do
    subject { Sources.new }

    describe '#total' do
      it 'should total up the damage values' do
        subject['a'] = 1
        subject['b'] = 2
        subject.total.should == 3
      end
    end
  end
end
