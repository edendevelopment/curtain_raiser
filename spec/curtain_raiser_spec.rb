require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CurtainRaiser" do

  context 'creation' do
    class CurtainDouble
      attr_reader :app, :block, :args

      def initialize(app, *args, &block)
        @app = app
        @block = block
        @args = args
      end
    end

    before(:each) do
      @app = mock(:app)
      @raiser = CurtainRaiser.new(@app, CurtainDouble, 1, 2, 3) { true }
    end

    def curtain
      @raiser.instance_variable_get('@curtain')
    end

    it "creates the curtain with the app" do
      curtain.app.should == @app
    end

    it "creates the curtain with the block" do
      curtain.block.call.should be_true
    end

    it "creates the curtain with the args" do
      curtain.args.should == [1,2,3]
    end
  end

  def curtain_raiser(app, login_response, should_raise)
    raiser = CurtainRaiser.new(app, mock(:curtain, :null_object => true, :call => login_response, :raise? => should_raise))
  end

  context 'when the request is not authorised' do
    it 'the login response is returned' do
      curtain_raiser(nil, nil, false).call(nil).should == nil
    end

    it 'the login response equals the one passed into' do
      login_response = 'hiya'
      curtain_raiser(nil, login_response, false).call(nil).should == login_response
    end
  end

  context 'when request is authorised' do
    it 'the app response is returned' do
      app = lambda {|environment| 'Awesome!'}
      environment = 'not nil ;)'
      curtain_raiser(app, nil, true).call(environment).should == 'Awesome!'
    end
  end

end
