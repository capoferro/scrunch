module Scrunch
  class Sources < Hash
    def damage_total
      aggregate :damage_total
    end

    def healing_total
      aggregate :healing_total
    end

    private
    
    def aggregate attribute
      self.values.inject(0) {|sum, x| sum + x.send(attribute)}
    end
  end
end
