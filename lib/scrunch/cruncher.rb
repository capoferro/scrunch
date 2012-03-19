require 'terminal-table'

module Scrunch
  module Cruncher
    class << self
      # Public: Primary processing loop. Reads in the file, building data structures for analysis and display
      # 
      # Returns a Hash of sources
      def crunch filename
        sources = Sources.new
        File.open filename do |log|
          while line = log.gets
            source_name, result = parse line
            sources[source_name] ||= Source.new(source_name)
            sources[source_name].add_effect_result parse_effect_result(result)
          end
        end
        sources
      end

      # Public: Process an individual line and update sources accordingly
      # TODO: Refactor so it returns a hash instead of updating the sources directly
      def parse(line)
        timestamp, source_with_id, target, ability, result = line.split /\]\s\[/
        source_name, _ = source_with_id.split /\s\{/
        [source_name, result]
      rescue ArgumentError => e # Will trigger on the first split. Be
                                # sure not to cause side effects
                                # before this has a chance to trigger
                                # as it calls #parse again with a
                                # repaired string
        if e.message =~ /invalid byte sequence/i
          properly_encoded_line = line.chars.collect do |i|
            i.valid_encoding? ? i : '?'
          end.join
          parse properly_encoded_line
        else 
          raise e
        end
      end

      # Public: Parses the result of the effect, the final chunk of the log entry
      #
      # Returns a Hash of result details
      def parse_effect_result(line)
        result_type, details = line.split /\]/
        effect = /\s\{\d*\}\:\s(.+)\s\{/.match(result_type)[1].downcase.to_sym
        amount, type, _ = /\((.*)\)/.match(details)[1].split /\s+/
        {effect: {effect => {amount: amount.to_i, type: type}}}
      end
    end
  end
end
