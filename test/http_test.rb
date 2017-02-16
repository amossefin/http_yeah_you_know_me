require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require 'socket'
require 'pry'

class HttpServerTest < Minitest::Test

i_suck_and_my_tests_are_order_dependent!()

  def test_protocol
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal "HTTP", response.body.split("\n")[2].split(" ")[1].split("/")[0]
  end

  def test_port
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal "9292", response.body.gsub(%r{</?[^>]+?>}, '').split("\n")[4].split(" ")[1]
  end

  def test_response_body
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal "Hello, World! (2)", response.body.split("\n").last.gsub(%r{</?[^>]+?>}, '') 
  end
end