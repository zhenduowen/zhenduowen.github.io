# frozen_string_literal: true

# Kramdown only treats $$...$$ as math. Add protected $...$ inline math so
# Markdown never consumes TeX escapes (for example \{) or table pipes (|).
require "kramdown-parser-gfm"

module Kramdown
  module Parser
    class InlineMathKramdown < GFM
      INLINE_DOLLAR_MATH_START = /(?<!\\)(?<!\$)\$(?!\$)(?!\s)((?:\\.|[^$\n])*?\S)\$(?!\$)/

      def initialize(source, options)
        super
        @span_parsers.insert(@span_parsers.index(:inline_math), :inline_dollar_math)
      end

      def parse_inline_dollar_math
        start_line_number = @src.current_line_number
        @src.pos += @src.matched_size
        @tree.children << Element.new(:math, @src[1], nil, category: :span,
                                                       location: start_line_number)
      end
      define_parser(:inline_dollar_math, INLINE_DOLLAR_MATH_START, '\\$')

      # Tables are parsed before spans. If all pipes on the current line are
      # inside inline math, leave the line to paragraph/span parsing instead.
      def parse_table
        return false if pipes_only_in_inline_math?

        super
      end

      private

      def pipes_only_in_inline_math?
        line = @src.rest.lines.first
        return false unless line&.include?('|')

        line.gsub(INLINE_DOLLAR_MATH_START, '').match?(/(?<!\\)\|/) == false
      end
    end
  end
end
