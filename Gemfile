source 'https://rubygems.org'


gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'


# gem 'sass-rails', github: 'rails/sass-rails', branch: 'master'
# gem 'sprockets-rails', github: 'rails/sprockets-rails', branch: 'master'
# gem 'sprockets', github: 'rails/sprockets', branch: 'master'
# gem 'babel-transpiler'

gem 'sass-rails', '~> 5.0'                    # Use SCSS for stylesheets
gem 'compass-rails'                           # Compass support
gem 'susy'                                    # Susy grids
gem 'modular-scale'                           # Modular scales for typography
gem 'uglifier', '>= 1.3.0'                    # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.2'                  # Use CoffeeScript for .coffee assets and views
gem 'haml-rails'                              # haml templating enginge
gem 'jquery-rails'                            # jQuery
gem 'turbolinks', '~> 5'                      # Fast Navigation
gem 'normalize-rails'                         # Normalize CSS
gem 'font-awesome-sass'                       # Font-awesome icon fonts
gem 'autoprefixer-rails'                      # autoprefixes vendor prefixes
gem 'active_link_to'                          # Wrapper around link_to


gem 'devise'                                  # users authentication framework
gem 'rolify'                                  # users role management
gem 'cancancan'                               # users permissions
gem 'simple_form'                             # more robust form generation
gem 'fog'                                     # Asset Managment with S3
gem 'carrierwave'                             # Attachment Management
gem 'mini_magick'                             # Image Processing
gem 'cocoon'

# Auditing models
gem "rails-observers", github: 'rails/rails-observers'
gem "audited", github: 'collectiveidea/audited'


group :development, :test do
  gem 'byebug', platform: :mri      # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'erb2haml'                    # Easy conversion from erb2haml
  gem 'pry-rails'                   # Replace IRB with Pry
  # gem 'quiet_assets'                # Remove asset errors from the console
  gem 'better_errors'               # Show errors in a better man7or
  gem 'binding_of_caller'           # Deeper stack traces for errors
  gem 'interface', :git => 'https://github.com/CreateTheBridge/Interface.git'
  gem 'rspec-rails'                 # functional test framework
  gem 'database_cleaner'            # cleans test database
  gem 'factory_girl_rails'          # test factory creation
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'                              # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'dotenv-rails', '1.0.2'               # Environment variable management
end

group :production do
  gem 'newrelic_rpm'                # Real-time analytics on application performance
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
