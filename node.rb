module Node
  module Container
    def add(node)
      children << node
    end

    def children
      @children ||= []
    end
  end

  module Visitable
    def accept(visitor)
      visitor.visit(self)
    end
  end

  module TextNode
    attr_reader :content

    def initialize(text = "")
      @content = text
    end
  end

  class Html
    include Container, Visitable
  end

  class Head
    include Container, Visitable
  end

  class Title
    include Container, Visitable, TextNode
  end

  class Body
    include Container, Visitable
  end

  class H1
    include Container, Visitable, TextNode
  end

  class P
    include Container, Visitable, TextNode
  end
end
