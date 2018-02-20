class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

    def current_mode cookie_mode
        @current_mode = cookie_mode
        puts @current_mode
    end

end
