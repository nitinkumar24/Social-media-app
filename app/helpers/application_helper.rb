module ApplicationHelper

    def markdown(text)
        renderer = Redcarpet::Render::SmartyHTML.new(filter_html: true,
                                                     hard_wrap: true,
                                                     prettify: true)
        markdown = Redcarpet::Markdown.new(renderer, markdown_layout)
        markdown.render(sanitize(text)).html_safe
    end

    def markdown_layout
        { autolink: true, space_after_headers: true, no_intra_emphasis: true,
          tables: true, strikethrough: true, highlight: true, quote: true,
          fenced_code_blocks: true, disable_indented_code_blocks: true,
          lax_spacing: true }
    end

    def time_conversion(time)
        current_time = Time.now
        dif = (current_time- time).to_i
        if dif < 60
            dif.to_s + "s"

        elsif dif > 60 and dif < 3600
            dif = dif/60
            dif.to_s + "m"
        elsif dif > 3600 and dif < 86400
            dif = dif/3600
            dif.to_s + "h"
        elsif dif > 86400
            dif = dif/86400
            dif.to_s + "d"
        end

    end

    def resource_name
        :user
    end

    def resource_class
        User
    end

    def resource
        @resource ||= User.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end

end
