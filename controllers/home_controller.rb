class HomeController < Controller
  def index
    response.write 'Hello World!'
  end

  def speak
    response.write 'Speaking: ' + request['text']
  end
end
