class CookieBasedAuthenticationCurtain
  def initialize(auth_token, expected_auth_hash)
    @auth_token, @expected_auth_hash = auth_token, expected_auth_hash
  end
  
  def raise?(environment)
    valid_cookie?(environment)
  end

  private
  def valid_cookie?(environment)
    cookies = Rack::Request.new(environment).cookies
    cookies.include?(@auth_token) && cookies[@auth_token] == @expected_auth_hash
  end
end
