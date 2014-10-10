require_relative "node"

html = Node::Html.new
  head = Node::Head.new
    head.add(Node::Title.new("The Title"))
  body = Node::Body.new
    body.add(Node::H1.new("Some Headline"))
    body.add(Node::P.new("More text..."))

html.add(head)
html.add(body)


class HtmlGeneratingVisitor
  def visit(node)
    node.accept(self)
  end

  def visit_html(node)
    puts "<html>"

    node.children.each do |child|
      child.accept(self)
    end

    puts "</html>"
  end

  def visit_head(node)
    puts "<head>"

    node.children.each do |child|
      child.accept(self)
    end

    puts "</head>"
  end

  def visit_title(node)
    puts "<title>#{node.content}</title>"
  end

  def visit_body(node)
    puts "<body>"

    node.children.each do |child|
      child.accept(self)
    end

    puts "</body>"
  end

  def visit_h1(node)
    puts "<h1>#{node.content}</h1>"
  end

  def visit_p(node)
    puts "<p>#{node.content}</p>"
  end
end

visitor = HtmlGeneratingVisitor.new

visitor.visit(html)
