module MarkdownHelper
  REDCARPET_OPTIONS = {
    filter_html: true,
    autolink: true,
    space_after_headers: true,
    no_intra_emphasis: true,
    fenced_code_blocks: true,
    tables: true,
    hard_wrap: true,
    xhtml: true,
    lax_html_blocks: true,
    strikethrough: true
  }.freeze

  def markdown(md_code)
    html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(html_render, REDCARPET_OPTIONS)
    markdown.render(md_code).html_safe
  end

  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      case language.to_s
      when /^(?=.*rb).*$/
        lang = 'ruby'
      when /^(?=.*yml).*$/
        lang = 'yaml'
      when /^(?=.*md).*$/
        lang = 'md'
      else
        lang = 'nothing'
      end

      CodeRay.scan(code, lang).div
    end
  end
end