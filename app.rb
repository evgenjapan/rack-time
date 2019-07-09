require_relative 'time_format'

class App

  DEFAULT_HEADERS = { 'Content-Type' => 'text/plain' }.freeze

  def call(env)
    @request = Rack::Request.new(env)
    @url = @request.path_info

    handle_request
  end

  private

  def handle_request
    case @url
    when '/time'
      time_response
    else
      not_found
    end
  end

  def time_response
    return bad_request("Bad request\n") if no_timeformat_params?

    time_format = DateTimeFormat.new(@request.params['format'])

    if time_format.valid_format?
      ok("#{time_format.get_time.to_s}\n")
    else
      bad_request("Unknown time format #{time_format.errors}\n")
    end
  end

  def not_found
    response(404, "Unknown url\n")
  end

  def ok(body = "OK\n")
    response(200, body.to_s)
  end

  def bad_request(error)
    response(400, error)
  end

  def response(status, body, headers = DEFAULT_HEADERS)
    Rack::Response.new([body], status, headers)
  end

  def no_timeformat_params?
    !@request.params.key?('format') || @request.params['format'].empty?
  end

end
