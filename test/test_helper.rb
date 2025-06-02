# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'simplecov'

SimpleCov.start do
  add_filter '/test/'
  track_files '**/*.rb'
end

# Require game.rb
$LOAD_PATH.unshift File.expand_path('../', __dir__)
require 'game'