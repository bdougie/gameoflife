#!/usr/bin/env ruby
# frozen_string_literal: true

# Run all tests
Dir.glob('test/*_test.rb').each { |file| require_relative file }