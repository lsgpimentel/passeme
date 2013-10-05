#User a postprocessor so the css's are already processed.
Rails.application.assets.register_postprocessor 'text/css', Sprockets::UrlRewriter unless Rails.application.config.assets.debug
