class ModeController < ApplicationController

    def select
        @modes = UserMode.where(user_id: current_user.id)
    end

    def add_open_mode

    end

    def set_mode
        random = SecureRandom.hex
        cookies[:_mode] = params[:name]
        puts cookies[:_mode]
        puts cookies[:_sociogram_session]
        if UserMode.where(user_id: current_user.id,mode: cookies[:_mode]).length > 0
            puts "inside if"
            redirect_to '/'
        else
            render 'mode/select' , modes: @modes
        end
    end



end

