class ModeController < ApplicationController

    def select
        @modes = UserMode.where(user_id: current_user.id)
        @has_open_mode = UserMode.where(user_id: current_user.id, mode: "open")
    end

    def add_open_mode
        UserMode.create(user_id: current_user.id, mode: "open")
        redirect_to '/mode/select', notice: 'successfully added open mode.Enjoy'
    end

    def set_mode
        cookies[:_mode] = params[:name]
        @modes = UserMode.where(user_id: current_user.id)
        if UserMode.where(user_id: current_user.id,mode: cookies[:_mode]).length > 0
            redirect_to '/', notice: 'Currently browsing in ' +cookies[:_mode] + " mode"
        else
            redirect_to '/mode/select' , modes: @modes
        end
    end



end

