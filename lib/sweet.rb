require "execjs"
require "multi_json"

class Sweet
  REQUIRES = %w(underscore escodegen sweet)
  # Sources = %w(require underscore escodegen sweet).map { |js| File.expand_path("../#{js}.js", __FILE__) }

  DEFAULTS = {}

  def initialize(options = {})
    @options = DEFAULTS.merge(options)
    puts js_context
    @context = ExecJS.compile(js_context)
  end

  def js_context

    source = (<<-JS)
      var require = (function() {
        var modules = {};
        var require = function(module) {
          return modules[module];
        };
    JS

    REQUIRES.each do |file|
      source << (<<-JS)

        ////////////////////////////////////////////////////////////
        // #{ file }.js START

        modules["#{file}"] = function() {
            var exports = {}, module = {};
            module.exports = exports;

            #{ read_source_file(file) }

            return exports;
        }.call({});

        // #{ file }.js END
      JS
    end
    source << (<<-JS)
        return require;
      }());
    JS
    source
  end

  def read_source_file(name)
    File.open(File.expand_path("../#{name}.js", __FILE__), "r:UTF-8").read
  end

  def compile(source)
    source = source.respond_to?(:read) ? source.read : source.to_s
    js = []
    js << "var sweet = require('sweet');"
    js << "var gen = require('escodegen');"
    js << "var source = #{json_encode(source)};"
    js << "var result = gen.generate(sweet.parse(source));"
    js << "return result;"
    @context.exec js.join("\n")
  end

  if MultiJson.respond_to? :dump
    def json_encode(obj)
      MultiJson.dump(obj)
    end
  else
    def json_encode(obj)
      MultiJson.encode(obj)
    end
  end
end
