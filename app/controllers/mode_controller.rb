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
        @modes = UserMode.where(user_id: current_user.id)
        if UserMode.where(user_id: current_user.id,mode: params[:name]).length > 0
            user = current_user
            user.current_mode = params[:name]
            user.save
            redirect_to '/', notice: 'Currently browsing in ' +params[:name] + " mode"
        else
            redirect_to '/mode/select' , notice: 'Please select a valid mode',modes: @modes
        end
    end



end

