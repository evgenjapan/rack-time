require_relative 'time_format'

class App

  ALLOWED_URLS = ['/time'].freeze

  def call(env)
    @request = Rack::Request.new(env)
    @url = @request.path_info

    handle_request
  end

  private

  def handle_request
    return not_found unless url_allowed?

    return bad_request('Bad request') if no_params?

    perform_response
  end

  def perform_response
    time_format = DateTimeFormat.new(@request.params['format'])

    if time_format.valid_format?
      ok(time_format.get_time.to_s + "\n")
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

  def response(status, body)
    [status, headers, [body]]
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def no_params?
    @request.params['format'].nil? || @request.params['format'].empty?
  end

  def url_allowed?
    ALLOWED_URLS.include? @url
  end

end
