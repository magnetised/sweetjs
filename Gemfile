source "http://rubygems.org"

gemspec

execjs_runtimes = {
  "RubyRacer" => "therubyracer",
  "RubyRhino" => "therubyrhino",
  "Mustang" => "mustang"
}

if ENV["EXECJS_RUNTIME"] && execjs_runtimes[ENV["EXECJS_RUNTIME"]]
  gem execjs_runtimes[ENV["EXECJS_RUNTIME"]], :group => :development
end

# Engine
gem ENV["MULTI_JSON_ENGINE"], :group => :development if ENV["MULTI_JSON_ENGINE"]

