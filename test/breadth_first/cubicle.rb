class Cubicle
  def initialize(seed, *ancestors)
    @seed  = seed
    @ancestors = ancestors
  end
  attr_reader :seed, :ancestors

  def position
    ancestors.last
  end

  def done?(cell)
    position == cell
  end

  def cell_even?(move)
    y,x = move
    (x*x + 3*x + 2*x*y + y + y*y + seed)
      .to_s(2)
      .count("1").even?
  end

  def valid_position?(move)
    move.none? {|coordinate| coordinate < 0 } &&
    cell_even?(move)
  end

  def fill_cell(move)
    return "O" if ancestors.include?(move)
    cell_even?(move) ? "." : "#"
  end

  def max(axis)
    ancestors.transpose[axis].max
  end

  def upper_bound_y
    max(0)
  end

  def upper_bound_x
    max(1)
  end

  def fill_row(row)
    (0..upper_bound_x+1).map {|x| fill_cell([row,x]) }.join
  end

  ###############
  #This section was just for fun.
  #Making to_s pretty
  #
  def to_s
    "#{as_string}\nnumber of ancestors:#{total_ancestors}"
  end

#make column header print vertically, to help with spacing
  def column_header
    (0..upper_bound_x+1)
      .to_a
      .map { |num| num.to_s.rjust((upper_bound_y + 1).to_s.size,'0')}
      .map { |num| num.chars }
      .transpose
      .map { |num| num.join }
      .map { |num| num.rjust(num.size + 5," ") }
      .join("\n") + "\n"
  end

  def as_string
    column_header +
      (0..upper_bound_y+1).map do |row|
      "#{row.to_s.rjust(4)} #{fill_row(row)}"
    end.join("\n")
  end

  #done with fun

  def children
    #this part. Too "clever".  I kept trying to make it pretty.
    y,x = position
    y_values = y-1, y+1
    x_values = x-1, x+1
    ([y].product(x_values) + y_values.product([x])) 
      .select {|m|
        !ancestors.include?(m) &&
        valid_position?(m)
    }
  end

  def total_ancestors
    ancestors.size - 1
  end

end
