# # gem 'redcarpet'用
# module MarkdownHelper
#   def markdown(text)
#     html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
#     unless @markdown
#       options = {
#         filter_html: true,
#         autolink: true,
#         space_after_headers: true,
#         no_intra_emphasis: true,
#         fenced_code_blocks: true,
#         tables: true,
#         hard_wrap: true,
#         xhtml: true,
#         lax_html_blocks: true,
#         strikethrough: true
#       }
#       renderer = Redcarpet::Render::HTML.new(options)
#       @markdown = Redcarpet::Markdown.new(renderer)
#     end

#     html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
#     markdown = Redcarpet::Markdown.new(html_render, REDCARPET_OPTIONS)
#     @markdown.render(text).html_safe
#   end

#   class HTMLwithCoderay < Redcarpet::Render::HomeController
#     def block_code(code, language)
#       CodeRay.scan(code, language || 'md').div
#     end
#   end
# end

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
      CodeRay.scan(code, language || 'md').div
    end
  end
end