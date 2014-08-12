class PrizesController < ApplicationController
  def destroy
    if logged_in?
      @prize.destroy
      respond_to do |format|
        format.html { redirect_to campaigns_url, notice: 'Prize was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_url
    end
  end
end
