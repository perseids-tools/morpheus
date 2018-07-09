#!/usr/bin/env ruby

require 'json'

examples = JSON.parse(File.read('./test/fixture.json'))

failures = []
examples.each do |example|
  input = example["input"]
  opts = example["opts"] || []
  expected = example["expected"]

  actual = IO.popen({ 'MORPHLIB' => 'stemlib' }, ['bin/cruncher', *opts], 'r+') do |io|
    io.puts(input)
    io.close_write
    io.read
  end

  if expected != actual
    failures << [input, opts, expected, actual]

    print 'F'
  else
    print '.'
  end
end
puts

result_text = begin
  example_text = examples.length == 1 ? "example" : "examples"
  failure_text = failures.length == 1 ? "failure" : "failures"

  "\n#{examples.length} #{example_text}, #{failures.length} #{failure_text}"
end

if failures.length > 0
  failures.each do |input, opts, expected, actual|
    puts "Input:    #{input.inspect} (Opts: #{opts})"
    puts "Expected: #{expected.inspect}"
    puts "Actual:   #{actual.inspect}"
    puts
  end

  puts result_text
  exit 1
end

puts
puts result_text
