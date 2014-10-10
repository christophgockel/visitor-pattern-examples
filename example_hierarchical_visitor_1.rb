require_relative "node"

html = Node::Html.new
  head = Node::Head.new
    head.add(Node::Title.new("The Title"))
  body = Node::Body.new
    body.add(Node::H1.new("Some Headline"))
    body.add(Node::P.new("More text..."))

html.add(head)
html.add(body)


class HierarchicalVisitor
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

  def visit_html(node)
    indent "<html>"

    node.children.each do |child|
      child.accept(self)
    end

    unindent "</html>"
  end

  def visit_head(node)
    indent "<head>"

    node.children.each do |child|
      child.accept(self)
    end

    unindent "</head>"
  end

  def visit_title(node)
    indented "<title>#{node.content}</title>"
  end

  def visit_body(node)
    indent "<body>"

    node.children.each do |child|
      child.accept(self)
    end

    unindent "</body>"
  end

  def visit_h1(node)
    indented "<h1>#{node.content}</h1>"
  end

  def visit_p(node)
    indented "<p>#{node.content}</p>"
  end
end

visitor = HierarchicalVisitor.new

visitor.visit(html)
