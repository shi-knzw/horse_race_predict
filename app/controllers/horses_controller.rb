class HorsesController < ApplicationController


    def index
      @horses = Horse.all 
    end

    def show
        @horse = Horse.find_by(id: params[:id])
    end


end
