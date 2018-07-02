require "metanorma/processor"

module Metanorma
  module M3d
    class Processor < Metanorma::Processor

      def initialize
        @short = :m3d
        @input_format = :asciidoc
        @asciidoctor_backend = :m3d
      end

      def output_formats
        super.merge(
          html: "html",
          doc: "doc"
        )
      end

      def version
        "Asciidoctor::M3d #{Asciidoctor::M3d::VERSION}"
      end

      def input_to_isodoc(file)
        Metanorma::Input::Asciidoc.new.process(file, @asciidoctor_backend)
      end

      def output(isodoc_node, outname, format, options={})
        case format
        when :html
          IsoDoc::M3d::HtmlConvert.new(options).convert(outname, isodoc_node)
        when :doc
          IsoDoc::M3d::WordConvert.new(options).convert(outname, isodoc_node)
        else
          super
        end
      end

    end
  end
end
