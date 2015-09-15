class Preprocessor
  def initialize(input_stream)
    @input_stream = input_stream
  end

  def each_processed_line
    while line = @input_stream.gets
      yield Line.new(line).processed
    end
  end

  class Line
    SPAN_WITH_CLASSES = /\[(\.\S+) ([^\]]+)\]/
    CITED_QUOTE = /\[([^\]]+)\]\(\^([^\)]+)\)/ # most confusing regex ever!
    EXERCISE = /\[\<exercise (.+) === (.+)\>\]/

    def initialize(text)
      @text = text
    end

    def processed
      @text.gsub(SPAN_WITH_CLASSES) {
        captures = Regexp.last_match.captures

        classes = captures[0].split('.').reject(&:empty?)
        content = captures[1]

        "<span class=\"#{classes.join(' ')}\">#{content}</span>"

      }.gsub(CITED_QUOTE) {
        captures = Regexp.last_match.captures

        quote = captures[0]
        source = captures[1]

        "<span class=\"cited\">#{quote} <span class=\"citation\">#{source}</span></span>"
      }.gsub(EXERCISE) {
        captures = Regexp.last_match.captures

        prompt = captures[0]
        answer = captures[1]

        %Q[<span class="exercise-prompt">#{prompt}</span><input type="text" class="exercise-answer" data-answer="#{answer}" size="#{answer.length}"/>]
      }

    end
  end
end
