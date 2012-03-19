module Scrunch
  class Sources < Hash
    def total
      self.values.inject(0) {|sum, x| sum + x}
    end
  end
end
