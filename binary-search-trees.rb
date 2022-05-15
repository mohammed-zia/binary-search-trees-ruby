class Node
  attr_accessor :left, :right, :data
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end


  def build_tree(array)
    if array.is_a?(Array)
      unless array.empty?
        p array
        mid_point = (array.size) / 2
        # puts mid_point
        root = Node.new(array[mid_point])
        root.left = build_tree(array[... mid_point])
        root.right = build_tree(array[mid_point + 1 ...])
        return root
      else
        return root
      end
    else
      return nil
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

tree = Tree.new([4,5,2,3,1,7,10])
tree.pretty_print