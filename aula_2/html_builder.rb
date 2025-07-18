class HtmlBuilder
  def initialize(&block)
    @html = ""
    instance_eval(&block) if block_given?
  end

  def div(content = nil, &block)
    @html << "<div>"
    if block_given?
      inner_builder = self.class.new(&block)
      @html << "\n" << inner_builder.result << "</div>\n"
    else
      @html << "#{content}</div>\n"
    end
  end

  def span(content = nil, &block)
    @html << "<span>"
    if block_given?
      inner_builder = self.class.new(&block)
      @html << "\n" << inner_builder.result << "</span>\n"
    else
      @html << "#{content}</span>\n"
    end
  end

  def result
    @html
  end
end


builder = HtmlBuilder.new do
  div do
    div "Conteúdo em div"
    span "Nota em div"
  end
  span "Nota de rodapé"
end

puts builder.result

