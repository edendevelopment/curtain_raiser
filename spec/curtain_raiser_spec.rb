require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CurtainRaiser" do
  #REQUEST = {"rack.version"=>[1, 1], "rack.input"=><StringIO:0x00000100d41b50>, "rack.errors"=><StringIO:0x00000100d41c68>, "rack.multithread"=>true, "rack.multiprocess"=>true, "rack.run_once"=>false, "REQUEST_METHOD"=>"GET", "SERVER_NAME"=>"example.org", "SERVER_PORT"=>"80", "QUERY_STRING"=>"", "PATH_INFO"=>"/", "rack.url_scheme"=>"http", "HTTPS"=>"off", "SCRIPT_NAME"=>"", "CONTENT_LENGTH"=>"0", "rack.test"=>true, "REMOTE_ADDR"=>"127.0.0.1", "HTTP_COOKIE"=>""}
  
  context 'when request is not authorised' do
    it 'the login response is returned' do
      raiser = CurtainRaiser.new(nil, nil) { |environment| false }
      login_response = nil
      environment = nil
      raiser.call(environment).should == login_response
    end

    it 'the login response equals the one passed into' do
      login_response = 'hiya'
      raiser = CurtainRaiser.new(nil, login_response) { |environment| false }
      environment = nil
      raiser.call(environment).should == login_response
    end
    it 'sets a cookie if the authorisation was successssssssful'
  end

  context 'when request is authorised' do
    it 'the app response is returned' do
      app = lambda {|environment| 'Awesome!'}
      raiser = CurtainRaiser.new(app, nil) {|environment| true }
      environment = 'not nil ;)'
      raiser.call(environment).should == 'Awesome!'
    end
  end

end
