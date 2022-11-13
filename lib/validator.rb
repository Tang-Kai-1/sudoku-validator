class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    @puzzle_string = @puzzle_string.gsub(/[^\d ^\s]/, '')
    splitString = @puzzle_string.split("\n").delete_if(&:empty?)
    splitRows = []
    splitString.each { |row|
      splitRows << row.split(' ').map(&:to_i)
    }
    splitColumns = splitRows.transpose()
    incomplete = false
    (0..splitRows.length - 1).step(3).each do |i|
      if ((splitRows[i].count(0) > 0 && splitRows[i].uniq.length + splitRows[i].count(0) - 1 != splitRows[i].length) ||
        (splitRows[i].count(0) == 0 && splitRows[i].uniq.length != splitRows[i].length) ||
        (splitRows[i+1].count(0) > 0 && splitRows[i+1].uniq.length + splitRows[i+1].count(0) - 1 != splitRows[i+1].length)||
        (splitRows[i+1].count(0) == 0 && splitRows[i+1].uniq.length != splitRows[i+1].length)||
        (splitRows[i+2].count(0) > 0 && splitRows[i+2].uniq.length + splitRows[i+2].count(0) - 1 != splitRows[i+2].length)||
        (splitRows[i+2].count(0) == 0 && splitRows[i+2].uniq.length != splitRows[i+2].length))
        return "Sudoku is invalid."
      elsif ((splitColumns[i].count(0) > 0 && splitColumns[i].uniq.length + splitColumns[i].count(0) - 1 != splitColumns[i].length) ||
        (splitColumns[i].count(0) == 0 && splitColumns[i].uniq.length != splitColumns[i].length)||
        (splitColumns[i+1].count(0) > 0 && splitColumns[i+1].uniq.length + splitColumns[i+1].count(0) - 1 != splitColumns[i+1].length)||
        (splitColumns[i+1].count(0) == 0 && splitColumns[i+1].uniq.length != splitColumns[i+1].length)||
        (splitColumns[i+2].count(0) > 0 && splitColumns[i+2].uniq.length + splitColumns[i+2].count(0) - 1 != splitColumns[i+2].length)||
        (splitColumns[i+2].count(0) == 0 && splitColumns[i+2].uniq.length != splitColumns[i+2].length))
        return "Sudoku is invalid."
      end
      (0..splitRows[i].length - 1).step(3).each do |j|
        section = []
        section.push(splitRows[i][j], splitRows[i][j + 1], splitRows[i][j + 2],
                     splitRows[i + 1][j], splitRows[i + 1][j + 1], splitRows[i + 1][j + 2],
                     splitRows[i + 2][j], splitRows[i + 2][j + 1], splitRows[i + 2][j + 2])
        if (section.any? { |element| element < 0 || element > 9 })
          return "Sudoku is invalid."
        elsif ((section.count(0) > 0 && section.uniq.length + section.count(0) - 1 != section.length) ||
          (section.count(0) == 0 && section.uniq.length != section.length))
          return "Sudoku is invalid."
        elsif (section.count(0) > 0)
          incomplete = true
        end
      end
    end
    #(0..splitRows.length - 1).each { |i|
    #  if ((splitRows[i].count(0) > 0 && splitRows[i].uniq.length + splitRows[i].count(0) - 1 != splitRows[i].length) ||
    #    (splitRows[i].count(0) == 0 && splitRows[i].uniq.length != splitRows[i].length))
    #    return "Sudoku is invalid."
    #  elsif ((splitColumns[i].count(0) > 0 && splitColumns[i].uniq.length + splitColumns[i].count(0) - 1 != splitColumns[i].length) ||
    #    (splitColumns[i].count(0) == 0 && splitColumns[i].uniq.length != splitColumns[i].length))
    #    return "Sudoku is invalid."
    #  end
    #}
    if (incomplete)
      return "Sudoku is valid but incomplete."
    else
      return "Sudoku is valid."
    end
  end
end
