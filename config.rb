###
# Asset directories
###
set :css_dir,    'assets/stylesheets'
set :js_dir,     'assets/javascripts'
set :images_dir, 'assets/images'

###
# Page options, layouts, aliases and proxies
###

set :index_file, "index.html"
activate :directory_indexes
activate :autoprefixer
activate :syntax

activate :sprockets do |c|
  c.expose_middleman_helpers = true
end

###
# Connet with Bower
###
sprockets.append_path File.join(root, 'bower_components')

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With layout
page "/findme.html", layout: "layout"
page "/work/*", layout: "scroll"
page "/process.html", layout: "scroll"
page "/style-guide.html", layout: "scroll"

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

# Deploy Configuration
activate :deploy do |deploy|
  deploy.deploy_method  = :git
  deploy.branch         = 'master'
  deploy.build_before   = true
  deploy.commit_message = 'Deploying to master'
end

###
# Blog
###
activate :blog do |blog|
  # blog layout
  blog.layout = "layout"
  # blog deirectory and url
  blog.prefix = "blog"
  # url article name
  blog.permalink = "{title}.html"

end

###
# Helpers
###
helpers do
  def active_link_to(text, path, options)
    # Define selected style
    active_css_class = "active" if current_page.url.delete('/') == path.delete('/')
    link_to text, "/#{path}".gsub('//', '/'), class: "#{options[:class]} #{active_css_class}"
  end

  def external_link_to(text, path, options)
    link_to text, path, target: "_blank", class: "#{options[:class]}"
  end

  def image_link(path, options)
    link_to path do
      image_tag path, class: "#{options[:class]}"
    end
  end
end

require "helpers/image_helpers"
helpers ImageHelpers
