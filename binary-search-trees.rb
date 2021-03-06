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
        # p array
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

  def preorder(root, &blk)
    # We'll implement the preorder traversal recursively.
    # Base case
    if root.nil? 
      return
    end
    # First, we yield the root node to the block
    blk.call(root.data)
    # Then we'll recursively call the function, passing the left child Node as an argument
    preorder(root.left, &blk)
    preorder(root.right, &blk)
  end

  def inorder(root, &blk)
    if root.nil?
      return
    end
    inorder(root.left, &blk)
    blk.call(root.data)
    inorder(root.right, &blk)
  end

  def postorder(root, &blk)
    if root.nil?
      return
    end
    postorder(root.left, &blk)
    postorder(root.right, &blk)
    blk.call(root.data)
  end

  def findTreeHeight(root, data)
    $height
 
    # Base Case
    if root == nil
        return -1
    end
    # Store the maximum height of
    # the left and right subtree
    leftHeight = findTreeHeight(root.left, data)
 
    rightHeight = findTreeHeight(root.right, data)
 
    # Update height of the current node
    ans = [leftHeight, rightHeight].max + 1
 
    # If current node is the required node
    if root.data == data
        $height = ans
    end
    return ans
  end
 
# Function to find the height of
# a given node in a Binary Tree
  def findNodeHeight(root, data)
    $height
 
    # Stores height of the Tree
    maxHeight = findTreeHeight(root, data)
 
    # Return the height
    return $height
  end

  def depth(root, data)
    if root == nil
      return -1
    end

    # Set initial depth to -1
    depth = -1

    if root.data == data
      return depth + 1
    end

    depth = depth(root.left, data)
    if depth >= 0
      return depth + 1
    end
    depth = depth(root.right, data)
    if depth >= 0
      return depth + 1
    end
    return depth
  end

  def height(root)
    # base condition when binary tree is empty
    if root.nil? == true
        return 0
    end
    return [height(root.left), height(root.right)].max + 1
  end

  def balanced?(root)
    if root.nil? == true
      return true
    end
    left_height = height(root.left)
    right_height = height(root.right)

    if (left_height - right_height).abs <= 1 && balanced?(root.left) == true && balanced?(root.right) == true
      return true
    end

    return false
  end
  
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '???   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '????????? ' : '????????? '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '???   '}", true) if node.left
  end  
end

def rebalance(tree)
  # This function rebalances an unbalanced tree by using a depth-first inorder traversal 
  # which will return the elements in a sorted array. This new array is then passed to the 
  # build_tree function to create the new balanced tree.
  new_array = []
  tree.inorder(tree.root) {|x| new_array << x}
  # p new_array
  Tree.new(new_array)
end

# DRIVER SCRIPT

# Create a binary search tree from an array of random numbers
tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print

# Confirm that the tree is balanced by calling #balanced?
puts "Tree balanced -> #{tree.balanced?(tree.root)}"

# Print all the elements in level, pre, post and inorder
level_ord = []
tree.level_order(tree.root) {|x| level_ord << x}
puts "Level Order: #{level_ord}"
puts "\n"

pre_ord = []
tree.preorder(tree.root) {|x| pre_ord << x}
puts "Preorder: #{pre_ord}"
puts "\n"

inord = []
tree.inorder(tree.root) {|x| inord << x}
puts "Inorder: #{inord}"
puts "\n"

postord = []
tree.postorder(tree.root) {|x| postord << x}
puts "Postorder: #{postord}"
puts "\n"

# Unbalance the tree by adding several numbers > 100
tree.insert(tree.root, 110)
tree.insert(tree.root, 155)
tree.insert(tree.root, 134)
tree.insert(tree.root, 197)
tree.insert(tree.root, 175)
tree.insert(tree.root, 132)
tree.insert(tree.root, 162)
tree.insert(tree.root, 123)
puts "\n"
puts "\n"
puts "New tree:"
puts "\n"
tree.pretty_print

# Confirm the tree is now unbalanced
puts "\n"
puts "Tree balanced -> #{tree.balanced?(tree.root)}"
puts "\n"

# Balance the tree by calling rebalance
new_tree = rebalance(tree)
new_tree.pretty_print

# Confirm the tree is now rebalanced
puts "\n"
puts "Tree balanced -> #{new_tree.balanced?(new_tree.root)}"
puts "\n"

# Print all the elements in level, pre, post and inorder
level_ord = []
new_tree.level_order(new_tree.root) {|x| level_ord << x}
puts "Level Order: #{level_ord}"
puts "\n"

pre_ord = []
new_tree.preorder(new_tree.root) {|x| pre_ord << x}
puts "Preorder: #{pre_ord}"
puts "\n"

inord = []
new_tree.inorder(new_tree.root) {|x| inord << x}
puts "Inorder: #{inord}"
puts "\n"

postord = []
new_tree.postorder(new_tree.root) {|x| postord << x}
puts "Postorder: #{postord}"
puts "\n"

