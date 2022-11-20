require_relative 'check_format'

class TimeRack
  def initialize(_application)

  end

  def call(env)
    request = Rack::Request.new(env)

    if valid_path?(request)
      show_time(request)
    else
      response("Page not found", 404, headers)
    end
  end

  def valid_path?(request)
    request.path == '/time'
  end

  def response(body, status, headers)
    Rack::Response.new(body, status, headers).finish
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def show_time(request)
    formats = request.params['format']
    time_format = CheckFormat.new(Time.now, formats)
    time_format.call

    if time_format.valid_format?

      response(time_format.result, 200, headers)
    else
      response("Unknown time format #{time_format.unknown_formats}\n", 400, headers)
    end
  end

end
