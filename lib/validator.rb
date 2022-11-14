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
    @splitRows = splitRow(splitString)
    @splitColumns = @splitRows.transpose()
    @incompleteSection = false
    (0..@splitRows.length - 1).step(3).each do |i|
      checkValidity = checkRowColumnValidity(i)
      if (checkValidity != nil)
        return checkValidity
      end
      (0..@splitRows[i].length - 1).step(3).each do |j|
        section = []
        section.push(@splitRows[i][j], @splitRows[i][j + 1], @splitRows[i][j + 2],
                     @splitRows[i + 1][j], @splitRows[i + 1][j + 1], @splitRows[i + 1][j + 2],
                     @splitRows[i + 2][j], @splitRows[i + 2][j + 1], @splitRows[i + 2][j + 2])
        sectionValidity = checkSectionValidity(section)
        if (sectionValidity != nil)
          return sectionValidity
        end
      end
    end

    return endState()

  end

  def splitRow(splitString)
    rows = []
    splitString.each { |row|
      rows << row.split(' ').map(&:to_i)
    }
    return rows
  end

  def checkRowColumnValidity(index)
    (index..index + 2).each { |i|
      if ((@splitRows[i].count(0) > 0 && @splitRows[i].uniq.length + @splitRows[i].count(0) - 1 != @splitRows[i].length) ||
        (@splitRows[i].count(0) == 0 && @splitRows[i].uniq.length != @splitRows[i].length))
        return "Sudoku is invalid."
      elsif ((@splitColumns[i].count(0) > 0 && @splitColumns[i].uniq.length + @splitColumns[i].count(0) - 1 != @splitColumns[i].length) ||
        (@splitColumns[i].count(0) == 0 && @splitColumns[i].uniq.length != @splitColumns[i].length))
        return "Sudoku is invalid."
      end
    }
    return nil
  end

  def checkSectionValidity(section)
    if (section.any? { |element| element < 0 || element > 9 })
      return "Sudoku is invalid."
    elsif ((section.count(0) > 0 && section.uniq.length + section.count(0) - 1 != section.length) ||
      (section.count(0) == 0 && section.uniq.length != section.length))
      return "Sudoku is invalid."
    elsif (section.count(0) > 0)
      @incompleteSection = true
    end
    return nil
  end

  def endState()
    if (@incompleteSection)
      return "Sudoku is valid but incomplete."
    else
      return "Sudoku is valid."
    end
  end
end
