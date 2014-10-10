require_relative "node"

html = Node::Html.new
  head = Node::Head.new
    head.add(Node::Title.new("The Title"))
  body = Node::Body.new
    body.add(Node::H1.new("Some Headline"))
    body.add(Node::P.new("More text..."))

html.add(head)
html.add(body)

class Visitor
  def visit(node)
    puts node.class.to_s

    node.children.each do |child|
      child.accept(self)
    end
  end
end

visitor = Visitor.new

visitor.visit(html)
