
require 'pry'
require 'socket'


class Server 

counter = 0
request_lines = []
  tcp_server = TCPServer.new(9292)
  while 1
  client = tcp_server.accept
  puts "Ready for a request"
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end
  puts "Got this request:"
  puts request_lines.inspect

  puts "Sending response."
  response = "<pre>" + request_lines.join("\n") + "</pre>"
  output = "<pre>Verb: #{request_lines[0].split(" ")[0]}\nPath: #{request_lines[0].split(" ")[1]}\nProtocol: #{request_lines[0].split(" ")[2]}\nHost:#{request_lines[5].split(":")[1]}\nPort: #{request_lines[5].split(":")[2]}\nOrigin: #{request_lines[5].split(":")[1]}\n#{request_lines[3]}\n</pre><html><head>Hello, World! (#{counter})</head><body></body></html>"
  headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output
  puts ["Wrote this response:", headers, output].join("\n")
  counter += 1
  client.close
end
puts "\nResponse complete, exiting."
end

#binding.pry