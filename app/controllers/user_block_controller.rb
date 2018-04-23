class UserBlockController < ApplicationController
    def blockkarnahai
        if current_user.email == "nitin241196@gmail.com" or current_user.email == "nitin.1510092@kiet.edu"
            puts params[:p]
            hua_kya = UserBlock.create(email: params[:p])
            @ho_gya =  hua_kya.email
        else
            @ho_gya =  "Rehne de bhai"
        end
    end
end
