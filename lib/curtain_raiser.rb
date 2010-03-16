class CurtainRaiser
  def initialize(application, login_response, &authorisation)
    @login_response = login_response
    @authorisation = authorisation
    @application = application
  end

  def call(environment)
    @authorisation.call(environment) ? @application.call(environment) : @login_response
  end

end
__END__
<html>
<head>
    <title>Eden Development Staging Server Login</title>
    <link rel="stylesheet" type="text/css" href="main.css">
</head>
<body>
	<h1>login</h1>
    <form method="post">
    Please enter your login credentials. If you require assistance, 
    please contact your project manager on 0845 0097 094.
    <label>Username<input type="text" name="username"></label><br>
    <label>Password<input type="password" name="password"></label><br>
    <input class="button" type="submit" value="login">
    </form>
</body></html>

