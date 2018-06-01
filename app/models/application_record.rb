class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def set_mode_for_model(mode)
        puts @current_mode = mode
      puts "lau"

    end

end
