require_relative 'preprocessor.rb'
require 'redcarpet'

if ARGV.length < 1
  puts "usage: ruby preprocessor.rb filename"
  puts "(processes <filename>.md and writes output to <filename>.html)"
  exit 1
end

filename = ARGV[0]
template_filename, input_filename, output_filename = 'template-2.html', filename + ".md", filename + ".html"

if input_filename == output_filename
  puts "error: input and output filenames are equal, which would overwrite the input file"
  exit 2
end

path_to_root_dir = '.'
if input_filename['/']
  path_to_root_dir = '..'
end

input = File.open(input_filename, 'r')
output = File.open(output_filename, 'w')
template = File.open(template_filename, 'r')

while line = template.gets
  line = line.gsub('$ROOT$', path_to_root_dir)

  if line['ABRACADABRA']
    markdown = ""
    Preprocessor.new(input).each_processed_line do |line|
      markdown += line
    end
    markdown_converter = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, quote: true, footnotes: true)
    output << markdown_converter.render(markdown)
  else
    output << line
  end
end

input.close
output.close
template.close
