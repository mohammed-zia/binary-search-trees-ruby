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
    # Base case
    if root.nil?
      return root
    else
      # If the data to be deleted is smaller than the root's key
      # then it lies in the left sub-tree
      if root.data > data 
        root.left = delete(root.left, data)
      # Elsif reverse is true it must lie in the right sub-tree
      elsif root.data < data
        root.right = delete(root.right, data)
      # Else it must be the node to be deleted
      else
        # Node with only one child or no child
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

        # Node with two children:
        # Get the inorder successor
        # (smallest in the right subtree)
        temp = minValueNode(root.right)
        
        # Copy the inorder successor's content to this node
        root.data = temp.data

        # Delete the inorder successor
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

  def level_order(root, &blk)
    # Need to traverse the BST breadth-first

    # Implement a queue to hold discovered node addresses whilst the children are visited to allow us to keep track
    # of our place in the tree (can't just go backwards)

    # As long as the tree has some discovered node (i.e. the tree is not empty) we can take out a node from the front of the queue,
    # visit it and then en-queue its children
    
    #       QUEUE
    # ---------------------
    # <- RootNodeAddr <-
    # ---------------------
    # >> Visit RootNode
    # ----------------------------
    # <- ChildNode1 <- ChildNode2
    # ----------------------------
    # >> Visit ChildNode1 and enqueue it's children, then move to ChildNode2 and so on....
    
    # FUNCTION START
    # If the root node is nil (i.e. empty) then just return
    if root.nil?
      return
    end
    queue = []
    queue.push(root)
    # While there is at least one discovered node
    while queue.empty? == false
      # Set the current node to the node at the front of the queue
      current_node = queue.first
      blk.call(current_node.data)
      # If the current node's left child is not nil, push it to the queue
      if current_node.left.nil? == false
        queue.push(current_node.left)
      end
      # If the current node's right child is not nil, push it to the queue
      if current_node.right.nil? == false
        queue.push(current_node.right)
      end
      # Remove the first element from the queue
      queue.shift
    end
  end
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

tree = Tree.new([4,7,6,3,10,14,13])
tree.pretty_print

# tree = Tree.new(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"])
# tree.pretty_print
# tree.level_order(tree.root) {|x| p x}