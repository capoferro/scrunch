require 'terminal-table'

module Scrunch
  class Cruncher
    attr_reader :sources

    def initialize(filename)
      @filename = filename
      @sources = {}
    end

    # Public: Primary processing loop. Reads in the file, building data structures for analysis and display
    # 
    # Returns a Hash of sources
    def crunch
      File.open @filename do |log|
        while line = log.gets
          parse line
        end
      end
      @sources
    end

    # Public: Process an individual line and update sources accordingly
    def parse(line)
      timestamp, source_with_id, target, ability, result = line.split /\]\s\[/
      source, _ = source_with_id.split /\s\{/
      @sources[source] ||= 0
      parsed_result = parse_result result
      @sources[source] += parsed_result[:effect][:damage][:amount] if parsed_result[:effect].keys.include? :damage
    rescue ArgumentError => e
      if e.message =~ /invalid byte sequence/i
        properly_encoded_line = line.chars.collect do |i|
          if i.valid_encoding?
            i
          else
            '?'
          end
        end.join

        parse properly_encoded_line
      else 
        raise e
      end
    end

    # Public: Parses the result of the effect, the final chunk of the log entry
    #
    # Returns a Hash of result details
    def parse_result(line)
      result_type, details = line.split /\]/
      effect = /\s\{\d*\}\:\s(.+)\s\{/.match(result_type)[1].downcase.to_sym
      amount, type, _ = /\((.*)\)/.match(details)[1].split /\s+/
      {effect: {effect => {amount: amount.to_i, type: type}}}
    end

    # Public: converts the sources Hash to an ordered array of tuples, highest damage first
    #
    # Returns Array of converted Hash elements
    def ordered_sources
      @sources.to_a.sort_by { |x| x[1] }.reverse
    end
  end
end
