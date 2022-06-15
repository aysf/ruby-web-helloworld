require 'socket'
require 'logger'

server = TCPServer.new(8090)

loop do
    client = server.accept

    # accept a http request and parse it
    request_line = client.readline
    method_token, target, version_number = request_line.split
    lg = Logger.new("see.log") 
    lg.level = Logger::INFO
    lg.info("🟠 received a #{method_token} request to #{target} with #{version_number}")


    # decide what to respond
    case [method_token, target]
    when ["GET", "/"]
        response_message = "<h1>Hello World from Ruby</h1>"
    when ["GET", "/about"]
        response_message = "<h1>Hello my name is Wicak</h1>"
    else
        response_message = "<h1>page not found :(</h1>"
    end

    # Construct the HTTP resond
    http_response = <<~MSG
        HTTP/1.1 200 OK
        Content-Type: text/html

        #{response_message}
    MSG
    
    client.puts(http_response)
    client.close
end