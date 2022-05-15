class Node
  attr_accessor :left, :right, :data
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root
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

  def insert(root, data)
    # If root is nil, we've reached the end of the branch so insert data
    if root.nil?
      return Node.new(data)
    else
      # If the current key is equal to the inserted data, return the node (no duplicates allowed)
      if root.data == data
        return root
      elsif
        # If the desired data value is greater than the current root node, recursively call on the right leaf
        root.data < data
        root.right = insert(root.right, data)
      else
        # Else the desired data value must be less than the current root node, recursively call on the left leaf
        root.left = insert(root.left, data)
      end
    end
    return root
  end

  def minValueNode(node)
    current = node
    while current.left.nil? == false
      current = current.left
    end
    return current
  end


  def delete(root, data)
    if root.nil?
      return root
    else
      if root.data > data 
        delete(root.left, data)
      elsif root.data < data
        delete(root.right, data)
      else
        if root.left == nil
          temp = root.right
          root.data = nil
          root = nil
          return temp
        elsif root.right == nil
          temp = root.left
          root.data = nil
          root = nil
          return temp
        end

        temp = minValueNode(root.right)

        root.data = temp.data

        root.right = delete(root.right, temp.data)
      end
    end
    return root
  end

  def find(root, data)
    if root.nil? || root.data == data
      return root
    end
    if root.data < data
      find(root.right, data)
    end
    find(root.left, data)
  end



  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

tree = Tree.new([4,7,6,1,3,8,10,14,13])
tree.pretty_print
tree.insert(tree.root, 15)
tree.pretty_print
tree.delete(tree.root, 1)
tree.pretty_print
tree.delete(tree.root, 4)
tree.pretty_print
tree.delete(tree.root, 13)
tree.pretty_print
tree.delete(tree.root, 15)
tree.pretty_print

puts tree.find(tree.root, 6)