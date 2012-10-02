# encoding: UTF-8

require "execjs"
require "multi_json"

class SweetJS
  VERSION = "0.1.0"
  REQUIRES = %w(underscore escodegen sweet)

  Error = ExecJS::Error

  def self.compile(source)
    self.new.compile(source)
  end

  def context
    @context ||= build_context
  end

  def build_context
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
      }.call(this));
    JS
    ExecJS.compile(source)
  end

  def read_source_file(name)
    File.open(File.expand_path("../sweetjs/#{name}.js", __FILE__), "r:UTF-8").read
  end

  def compile(source)
    source = source.respond_to?(:read) ? source.read : source.to_s
    js = []
    js << "var sweet = require('sweet');"
    js << "var escodegen = require('escodegen');"
    js << "var source = #{json_encode(source)};"
    js << "var result = escodegen.generate(sweet.parse(source));"
    js << "return result;"
    context.exec js.join("\n")
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
