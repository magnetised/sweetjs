require "execjs"
require "multi_json"

class Sweet
  Sources = %w(require underscore escodegen sweet).map { |js| File.expand_path("../#{js}.js", __FILE__) }

  DEFAULTS = {}

  def initialize(options = {})
    @options = DEFAULTS.merge(options)
    @context = ExecJS.compile(context)
  end

  def context

    Sources.map { |source| puts source; File.open(source, "r:UTF-8").read }.join("\n")
  end

  def compile(source)
    source = source.respond_to?(:read) ? source.read : source.to_s
    js = []
    # js << "var _ = exports._"
    js << "var source = #{json_encode(source)};"
    js << "var result = exports.generate(exports.parse(source));"
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
