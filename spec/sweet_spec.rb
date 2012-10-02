# encodeing: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SweetJS" do
  let(:source) {
    (<<-JS)
      macro def {
        case $name:ident $params $body => {
          function $name $params $body
        }
      }
      def sweet(a) {
        console.log("Macros are sweet!");
      }
    JS
  }

  it "compiles macros" do
    compiled = SweetJS.new.compile(source)
    compiled.should =~ /function sweet/
  end

  it "has a class method to compile macros" do
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

  it "compiles IO objects as well as strings" do
    io = StringIO.new(source)
    lambda {
      SweetJS.compile(io).should =~ /function sweet/
    }.should_not raise_error(SweetJS::Error)
  end
end
