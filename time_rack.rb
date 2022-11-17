require_relative 'check_format'

class TimeRack
  def initialize(app)
    @app = app
  end

  def call(env)
    @request = Rack::Request.new(env)
    if valid_path?
      show_time
    else
      response("Path not found", 404, headers)
    end
  end

end

def valid_path?
  @request.path == '/time'
end

def response(body, status, headers)
  Rack::Response.new(body, status, headers).finish
end

def headers
  {'Content-type' => 'plain/text'}
end

def show_time
  time = Time.nowkerni2/RackTime
  formats = @request.params["format"]
  time_format = CheckFormat.new(time, formats)
  time_format.call

  if time_format.valid_format?
    response(time_format.result, 200, headers)
  else
    response("Unknown time format #{time_format.unknown_formats}\n", 400, headers)
  end
end
