

class Node
  attr_accessor :root, :move_1, :move_2, :move_3, :move_4,
  :move_5, :move_6, :move_7, :move_8, :parent

  def initialize(root)
    @root = root
    @move_1 = nil
    @move_2 = nil
    @move_3 = nil
    @move_4 = nil
    @move_5 = nil
    @move_6 = nil
    @move_7 = nil
    @move_8 = nil
    @parent = nil
  end

end

class Tree

  board = []
  for i in 0..7 do
    for j in 0..7 do
      board << [i, j]
    end 
  end

  @@free = board

  def initialize(node, free)
    @node = node
    @free = free
  end

  #position is node.root
  def calculate_moves(position, free)
    arr = []
    for i in -2..2 do
      for j in -2..2 do
        next if i.abs == j.abs || i == 0 || j == 0
        arr << [position[0] + i, position[1] + j] if free.includes?([position[0] + i, position[1] + j])
      end
    end
    arr
  end

  def build_tree(node, free)
    possible_moves = calculate_moves(node.root, free)
    children = [node.move_1, node.move_2, node.move_3, node.move_4, node.move_5, node.move_6, node.move_7, node.move_8]

    children.each do |child, index|
      if possible_moves(index)
        child = Node.new(possible_moves(index)) 
        child.parent = node.root
        @@free.delete(child)
      end
    end
  end
   
end


# Create board
# A knight position is a node, its position on the board represent its value
# The current position is the root of the tree
# The possible moves are children of the node
  # exclude positions that are outside the board
  # exclude position that aldready exist in the tree
# If the children don't include the target:
  # Create a tree of the possible moves from each child
  # Append the newly created trees to the first tree
  # The new trees mus ll be on the same level
  # if the target is spotted: print the path from the begining
  # Else...repeat


