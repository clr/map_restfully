require 'rubygems'
# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

gem 'rails', '3.0.9'
require "action_controller/railtie"
require "rails/test_unit/railtie"
require 'rails/test_help'
require File.expand_path('../../lib/map_restfully', __FILE__)

module Test
  class Application < Rails::Application
  end
end
Test::Application.config.secret_token = ("testingframework" * 2)

def app
  Test::Application.routes.draw do
    map_restfully :chair
    match("/url" => "controller#action", :as => :nothing)
  end
  Test::Application
end

# helper for a common assertion
def assert_ok
  assert last_response.ok?, "Response was not ok: #{last_response.status}"
end

# helper for looping through the HTTP verbs
def each_http_verb(&block)
  %w(GET POST PUT DELETE).each do |verb|
    yield verb
  end
end

class ChairsController < ActionController::Base
  include Test::Application.routes.url_helpers

  # singular actions
  each_http_verb do |verb|
    define_method verb.downcase.to_sym do
      response = params[:id].nil? ? "new chair" : "chair number #{params[:id]}"
      respond_to do |format|
        format.html{render :text => "HTML #{verb} #{response}"}
        format.js{  render :text => "JSON #{verb} #{response}"}
      end
    end
  end
  # plural actions
  each_http_verb do |verb|
    define_method "#{verb.downcase}s".to_sym do
      response = params[:ids].nil? ? "all chairs" : "chairs numbered #{params[:ids].split(',').join(" and ")}"
      respond_to do |format|
        format.html{render :text => "HTML #{verb}S #{response}"}
        format.js{  render :text => "JSON #{verb}S #{response}"}
      end
    end
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting

  # Add more helper methods to be used by all tests here...
end
