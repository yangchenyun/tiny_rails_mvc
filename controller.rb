require 'erb'

class Controller
  attr_accessor :request, :response, :action_name
  attr_reader :rendered

  def initialize(action_name)
    @action_name = action_name
    @rendered = false
  end

  def render(name = action_name)
    return if @rendered
    template = load_template(name)
    html = template.result(binding)
    response.write html
    @rendered = true
  end

  def load_template(name)
    path = resolve_template_path(name)
    ERB.new(File.read(path))
  end

  # UsersController, action => users/index
  def resolve_template_path(name)
    controller_name = self.class.name.gsub(/Controller$/, '').downcase
    return "views/#{controller_name}/#{name}.html.erb"
  end
end
