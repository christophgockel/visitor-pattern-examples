module Node
  module Container
    def add(node)
      children << node
    end

    def children
      @children ||= []
    end
  end

  class Html
    include Container
  end

  class Head
    include Container
  end

  class Body
    include Container
  end

  class H1
    include Container
  end

  class P
    include Container
  end
end
