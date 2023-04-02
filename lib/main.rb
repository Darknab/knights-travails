# frozen_string_literal: true

require 'pry-byebug'

class Node
  attr_accessor :root, :children, :parent

  def initialize(root)
    @root = root
    @children = Array.new(8)
    @parent = nil
  end
end

class Tree
  attr_accessor :node

  board = []
  (1..8).each do |i|
    (1..8).each do |j|
      board << [i, j]
    end
  end

  @@free = board

  def initialize(node)
    @node = node
  end

  # position is node.root
  def calculate_moves(position)
    arr = []
    (-2..2).each do |i|
      (-2..2).each do |j|
        next if i.abs == j.abs || i.zero? || j.zero?

        arr << [position[0] + i, position[1] + j] if @@free.include?([position[0] + i, position[1] + j])
      end
    end
    arr
  end

  def build_tree(node)
    return if @@free.empty?

    possible_moves = calculate_moves(node.root)

    possible_moves.each do |element|
      child = Node.new(element)
      child.parent = node
      node.children << child
      @@free.delete(child.root)
    end
  end

  def level_order(node, queue = [node], order = [])
    until queue.empty?
      yield queue[0] if block_given?
      order.push(queue[0].root)
      queue[0].children.each do |child|
        queue.push(child) if child
      end
      queue.delete_at(0)
    end
    order
  end

  def find_path(node, path = [])
    path.unshift(node.root)
    find_path(node.parent, path) if node.parent
    path
  end

  def print_result(node)
    path = find_path(node)
    puts "You made it in #{path.length - 1} moves! Here's your path:"
    p path
  end
end

def knight_moves(start, target)
  knight = Node.new(start)
  moves = Tree.new(knight)
  moves.build_tree(knight)
  moves.level_order(knight) do |node|
    return moves.print_result(node) if node.root == target

    moves.build_tree(node)
  end
end

knight_moves([8, 8], [1, 1])
