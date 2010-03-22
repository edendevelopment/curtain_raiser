require 'curtain_raiser/curtains'

class CurtainRaiser
  def initialize(application, curtain, *args, &block)
    @application = application
    @curtain = curtain.new(@application, *args, &block)
  end

  def call(environment)
    @curtain.raise?(environment) ? @application.call(environment) : @curtain.call(environment)
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

