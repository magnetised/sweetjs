# encodeing: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sweet" do
  it "compiles macros" do
    source = (<<-JS)
      macro def {
        case $name:ident $params $body => {
          function $name $params $body
        }
      }
      def sweet(a) {
        console.log("Macros are sweet!");
      }
    JS
    compiled = Sweet.new.compile(source)
    puts compiled
  end
end
