require 'jquery-rails'
require 'carrierwave'
require 'mini_magick'
require 'ckeditor'
require 'acts-as-taggable-on'

module SimpleBlog
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end

    initializer "simple_blog.assets.precompile" do |app|
      app.config.assets.precompile += %w(admin.js)
    end

  end
end
