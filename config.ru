require File.expand_path('timer', File.dirname(__FILE__))

app = Rack::Builder.new do
  use Rack::ETag
  use Rack::ConditionalGet
  use Rack::Deflater
  run Timer
end

Rack::Handler::Thin.run app
