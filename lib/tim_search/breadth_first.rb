module TimSearch
  class BreadthFirst
    def initialize(nodes)
      @queue = *nodes
      @root = @queue.last
      check_implementation
    end

    attr_accessor :queue, :root

    def find(cell)
      loop do
        current = queue.shift
        return current if current.done?(cell)
        add_paths(current)
      end
    end

    def add_paths(current)
      current.children.each do |move|
        queue << Cubicle.new(current.seed, *current.ancestors , move)
        yield move if block_given?
      end
    end

    def children_within(max)
      unique_moves = { [1,1 ] => 0 }
      while queue.size > 0 do
        current = queue.shift
        if current.total_ancestors < max
          add_paths(current) { |move| unique_moves[move] = 0 }
        end
      end
      return unique_moves.size
    end

    private

    def check_implementation
      %w[children,ancestors]
      unless root.respond_to?("children") 
        raise NoMethodError, "method 'children' hasn't been implementd"
      end
    end

  end


end
