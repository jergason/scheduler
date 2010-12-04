module Scheduler
  module Helpers
    def select(opts={})
      opts[:title] ||= opts[:name]
      res = "<select name=\"#{opts[:name]}\" title=\"#{opts[:title]}\">\n"
      options = opts[:options].inject(res) do |res, option|
        res << "\t<option value=\"#{option}\">#{option}</option>\n"
      end
      options << "</select>\n"
    end

    def sample_type_options()
      ["lipid", "protein", "digested protein/peptide", "metabolite"]
    end

    def sample_origin_options()
      ["purified protein", "co-immunoprecipitation", "cell/tissue lysates", "plasma", "media"]
    end
  end
end
