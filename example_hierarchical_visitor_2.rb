require_relative "node"

html = Node::Html.new
  head = Node::Head.new
    head.add(Node::Title.new("The Title"))
  body = Node::Body.new
    body.add(Node::H1.new("Some Headline"))
    body.add(Node::P.new("More text..."))

html.add(head)
html.add(body)

class Node::Html; include Node::VisitableContainer; end
class Node::Head; include Node::VisitableContainer; end
class Node::Body; include Node::VisitableContainer; end


class RealHierarchicalVisitor
  def initialize
    @level = 0
  end

  def indent(text)
    indented text
    @level += 1
  end

  def unindent(text)
    @level -= 1
    indented text
  end

  def indented(text)
    puts "#{'  ' * @level}#{text}"
  end

  def visit(node)
    node.accept(self)
  end

  def visit_enter_html(node)
    indent "<html>"
    true
  end

  def visit_leave_html(node)
    unindent "</html>"
    true
  end

  def visit_enter_head(node)
    indent "<head>"
    true
  end

  def visit_leave_head(node)
    unindent "</head>"
    true
  end

  def visit_title(node)
    indented "<title>#{node.content}</title>"
  end

  def visit_enter_body(node)
    indent "<body>"
    true
  end

  def visit_leave_body(node)
    unindent "</body>"
    true
  end

  def visit_h1(node)
    indented "<h1>#{node.content}</h1>"
  end

  def visit_p(node)
    indented "<p>#{node.content}</p>"
  end
end

visitor = RealHierarchicalVisitor.new

visitor.visit(html)
