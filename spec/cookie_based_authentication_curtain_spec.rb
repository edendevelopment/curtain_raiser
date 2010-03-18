require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'rack'

describe 'Curtain' do
  before(:each) do
    @environment = {'HTTP_COOKIE' => "#{@auth_token}=#{@cookie_value}"}
  end

  def environment(cookie)
    { 'HTTP_COOKIE' => cookie }
  end

  context 'raises' do
    it 'if the cookie value is correct' do
      cookie_data = ['1','2']
      CookieBasedAuthenticationCurtain.new(*cookie_data).raise?(environment(cookie_data.join('='))).should be_true
    end

  end

  context 'does not raise' do
    it 'if the cookie value is incorrect' do
      CookieBasedAuthenticationCurtain.new(@auth_token, :not_something).raise?(@environment).should be_false
    end
  end

end
