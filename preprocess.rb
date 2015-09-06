require_relative 'preprocessor.rb'
require 'redcarpet'

if ARGV.length < 2
  puts "usage: ruby preprocessor.rb inputfile outputfile"
  exit 1
end

input_filename, output_filename = ARGV
template_filename = 'template.html'

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
