# encodeing: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SweetJS" do
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
    compiled = SweetJS.new.compile(source)
    compiled.should =~ /function sweet/
  end

  it "has a class method to compile macros" do
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
    compiled = SweetJS.compile(source)
    compiled.should =~ /function sweet/
  end

  it "throws an exception when compilation fails" do
    lambda {
      compiled = SweetJS.new.compile((<<-JS))
        def sweet(a) { console.log("Macros are sweet!"); }
      JS
    }.should raise_error(SweetJS::Error)
  end
end
