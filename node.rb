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
      class_name = self.class.to_s.split('::').last.downcase
      method_name = "visit_#{class_name}".to_sym

      if visitor.respond_to? method_name
        visitor.send method_name, self
      else
        visitor.visit self
      end
    end
  end

  module VisitableContainer
    def accept(visitor)
      if visitor.send enter_method_name, self
        self.children.each { |child| child.accept(visitor) }
      end
      visitor.send leave_method_name, self
    end

    private

    def class_name
      self.class.to_s.split('::').last.downcase
    end

    def enter_method_name
      "visit_enter_#{class_name}".to_sym
    end

    def leave_method_name
      "visit_leave_#{class_name}".to_sym
    end
  end

  module TextNode
    attr_reader :content

    def initialize(text = "")
      @content = text
    end
  end

  class Html
    include Visitable, Container
  end

  class Head
    include Visitable, Container
  end

  class Title
    include Visitable, Container, TextNode
  end

  class Body
    include Visitable, Container
  end

  class H1
    include Visitable, Container, TextNode
  end

  class P
    include Visitable, Container, TextNode
  end
end
