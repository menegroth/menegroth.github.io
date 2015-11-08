require_relative 'preprocessor.rb'
require 'redcarpet'

if ARGV.length < 3
  puts "usage: ruby preprocessor.rb template inputfile outputfile"
  exit 1
end

template_filename, input_filename, output_filename = ARGV

if input_filename == output_filename
  puts "error: input and output filenames are equal, which would overwrite the input file"
  exit 2
end

input = File.open(input_filename, 'r')
output = File.open(output_filename, 'w')
template = File.open(template_filename, 'r')

while line = template.gets
  if line['ABRACADABRA']
    markdown = ""
    Preprocessor.new(input).each_processed_line do |line|
      markdown += line
    end
    markdown_converter = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, quote: true)
    output << markdown_converter.render(markdown)
  else
    output << line
  end
end

input.close
output.close
template.close
