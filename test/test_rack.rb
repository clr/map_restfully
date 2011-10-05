require File.expand_path('../helper', __FILE__)
require 'rack/test'

class TestRack < ActiveSupport::TestCase
  include Rack::Test::Methods

  each_http_verb do |verb|
    test "#{verb} request to singular resource" do
      self.send(verb.downcase.to_sym, "/chair")
      assert_ok
      assert_equal "HTML #{verb} new chair", last_response.body
    end
  end

  each_http_verb do |verb|
    test "#{verb} request to singular resource by resources ID" do
      self.send(verb.downcase.to_sym, "/chair/42")
      assert_ok
      assert_equal "HTML #{verb} chair number 42", last_response.body
    end
  end

  each_http_verb do |verb|
    test "#{verb} request to singular resource by resources ID in another format" do
      self.send(verb.downcase.to_sym, "/chair/42.js")
      assert_ok
      assert_equal "JSON #{verb} chair number 42", last_response.body
    end
  end

  each_http_verb do |verb|
    test "#{verb} request to plural resource" do
      self.send(verb.downcase.to_sym, "/chairs")
      assert_ok
      assert_equal "HTML #{verb}S all chairs", last_response.body
    end
  end

  each_http_verb do |verb|
    test "#{verb} request to plural resource by resources IDs" do
      self.send(verb.downcase.to_sym, "/chairs/42,37")
      assert_ok
      assert_equal "HTML #{verb}S chairs numbered 42 and 37", last_response.body
    end
  end

  each_http_verb do |verb|
    test "#{verb} request to plural resource by resources IDs in another format" do
      self.send(verb.downcase.to_sym, "/chairs/42,37.js")
      assert_ok
      assert_equal "JSON #{verb}S chairs numbered 42 and 37", last_response.body
    end
  end
end
