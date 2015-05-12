# Day 2 Self-Study

# FIND:

# Find out how to access files with and without code blocks. What is the benefit of the code blocks?
#   Functions below - open_file_with_block/open_file_without_block
#   Benefit of code blocks: File is closed automatically at the end of the block.
# How would you translate a hash into an array? Can you translate arrays into hashes?
#   Functions below - convert_hash_to_array, convert_array_to_hash
# Can you iterate through a hash?
#   Yes - with each
# You can use Ruby arrays as stacks. What other common data structures do arrays support?
#   Queue... what else is supported natively? You could implement a tree or a matrix.

# DO:

# 1. Print the contents of an array of sixteen numbers, four numbers at a time, using just each. Now do the same with
# each_slice in Enumerable - exercise_1
# 2. The Tree class was interesting, but it did not allow you to specify a new tree with a clean user interface.
# Let the initializer accept a nested structure of hashes.
# You should be able to specify a tree like this:
# {'grandpa' => {'dad' => {'child 1' => {}, 'child 2' => {}}, 'uncle' => {'child 3' => {}, 'child 4' => {}}}}
# - class Tree, test_tree
# 3. Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line.
# You will need to do a simple regular expression match and read lines from a file. If you want, include line numbers.
# - grep

def open_file_with_block(path)
  File.open(path, "r") do |f|
   f.each_line do |line|
    #do something
   end
  end
end

def open_file_without_block(path)
  f = File.open(path, "r")
   f.each_line do |line|
    # do something
   end
   f.close
end

def convert_hash_to_array(hash_to_convert)
  #arr = Array.new(hash_to_convert.length) {Array.new(2)}
  arr = []
  hash_to_convert.each  {|key, value| arr.push([key, value])}
  return arr
end

def test_convert_hash_to_array
  my_hash = { "Jane Doe" => 10, "Jim Doe" => 6, "Blah" => 8 }
  new_arr = convert_hash_to_array(my_hash)
  new_arr.each{|e| puts("Element is #{e}")}
end

def convert_array_to_hash(array_to_convert)
  hash = Hash.new
  array_to_convert.each do |el|
    index = array_to_convert.index(el)
    hash[index] = el
  end
  return hash
end

def test_convert_array_to_hash
  my_array = ['This', 'is', 'my', 'array']
  new_hash = convert_array_to_hash(my_array)
  new_hash.each{|k,v| puts("Element is #{k}, #{v}")}
end

def exercise_1
  arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]

  # Using each
  slice = []
  arr.each do |el|
    slice.push(el)
    if (arr.index(el) != 0 and arr.index(el) % 4 == 3)
      puts(slice.to_s)
      slice = []
    end
  end

  # Using each_slice
  arr.each_slice(4) {|slice| puts(slice.to_s)}
end

class Tree
  attr_accessor :children, :node_name

  def initialize(root)

    if (root.length > 1)
      raise 'Too many root nodes!'
    end

    @node_name = root.keys.first
    child_hash = root.values.first

    the_children = []

    if child_hash != nil
      child_hash.each do |key, value|
        the_children.push(Tree.new({key => value}))
      end
    end

    @children = the_children

  end

  #def initialize(name, children=[])
  #  @children = children
  #  @node_name = name
  #end

  def visit_all(&block)
    visit &block
    children.each{|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end

  def to_s
    puts '## Tree:'
    puts @node_name
    puts @children.to_s
    puts '## End'
  end
end

def test_tree
  hash_tree = {'grandpa' => {'dad' => {'child 1' => {}, 'child 2' => {}}, 'uncle' => {'child 3' => {}, 'child 4' => {}}}}
#ruby_tree = Tree.new("Ruby", [Tree.new("Reia"), Tree.new("MacRuby")])
  ruby_tree = Tree.new(hash_tree)

  puts 'Visiting a node'
  ruby_tree.visit{|node| puts node.node_name}

  puts 'Visiting entire tree'
  ruby_tree.visit_all{|node| puts node.node_name}
end

def grep(file, pattern)
  to_match = Regexp.new(pattern)
  File.open(file, 'r') do |f|
    line_num = 0
    f.each_line do |line|
      line_num += 1
      if (to_match.match(line) != nil)
        puts "#{line_num}: #{line}"
      end
    end
  end
end

puts 'Enter a filename'
file = gets.chomp
puts 'Enter a string to find'
pattern = gets.chomp
grep(file, pattern)