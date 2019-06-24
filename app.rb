class App

  def call(env)
    perform_request(env[:QUERY_STRING])
    [status, headers, body]
  end

  private

  def perform_request(query)
    sleep rand(2..3)
  end

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["Welcome!!\n"]
  end

end
