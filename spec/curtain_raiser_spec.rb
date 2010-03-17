require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CurtainRaiser" do

  def curtain_raiser(app, login_response, should_raise)
    raiser = CurtainRaiser.new(app, mock(:curtain, :call => login_response, :raise? => should_raise))
  end

  context 'when the request is not authorised' do
    it 'the login response is returned' do
      curtain_raiser(nil, nil, false).call(nil).should == nil
    end

    it 'the login response equals the one passed into' do
      login_response = 'hiya'
      curtain_raiser(nil, login_response, false).call(nil).should == login_response
    end

    context 'while requesting authorisation to continue to the desired app' do
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
