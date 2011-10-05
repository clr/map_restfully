require File.expand_path('../helper', __FILE__)

class TestRoutes < ActiveSupport::TestCase

  test "that a named routes exist for singular and plural resource" do
    assert app.routes.named_routes[:chair].is_a?(ActionDispatch::Routing::Route),  "Singular named route not found."
    assert app.routes.named_routes[:chairs].is_a?(ActionDispatch::Routing::Route), "Plural named route not found."
  end

  each_http_verb do |verb|
    test "that a map exists in the router for #{verb} resource singular" do
      assert saved_route = app.routes.routes.detect{|r| r.verb == verb && r.path == "/chair(/:id(.:format))"}, "Route not found for #{verb} resource"
      assert_equal({:controller => 'chairs', :action => verb.downcase}, saved_route.requirements)
    end
  end

  each_http_verb do |verb|
    test "that a map exists in the router for #{verb} resource plural" do
      assert saved_route = app.routes.routes.detect{|r| r.verb == verb && r.path == "/chairs(/:ids(.:format))"}, "Route not found for #{verb} resource"
      assert_equal({:controller => 'chairs', :action => "#{verb.downcase}s"}, saved_route.requirements)
    end
  end
end
