module Scrunch
  class Source
    attr_reader :name, :damage_total, :healing_total

    def initialize(name)
      @name = name
      @damage_total = 0
      @healing_total = 0
    end

    # Public: Takes in parsed results and adds to the appropriate metrics
    def add_effect_result(result)
      @damage_total += result[:effect][:damage][:amount] if result[:effect].keys.include? :damage
      @healing_total += result[:effect][:heal][:amount] if result[:effect].keys.include? :heal
    end

  end
end
