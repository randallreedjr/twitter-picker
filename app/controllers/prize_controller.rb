class PrizeController < ApplicationController
  def destroy
    @prize.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Prize was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
