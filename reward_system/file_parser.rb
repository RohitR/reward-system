# frozen_string_literal: true

module RewardSystem
  # Parsing the input string command
  class FileParser
    REGEX = %r{
      ^
      (?: (?<datetime>\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}))?\s
      (?<customer> [a-zA-Z]+?)?\s
      (?<action> recommends|accepts|rejects)?
      (?<friend> \s[a-zA-Z]*|)
      $
    }x

    def self.build(file)
      File.readlines(file).filter_map do |line|
        REGEX.match(line.chomp)
      end
    end
  end
end
