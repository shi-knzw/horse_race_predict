class JockeysController < ApplicationController

  def index
    @jockeys = Jockey.all
  end

  def show

  end
  
end
