class GameSettingsController < ApplicationController
  include BilgePump::Controller
  respond_to :html, :json

  model_class GameSetting

  def gmview
    @game_setting = GameSetting.find(params[:game_setting_id])
    @characters = @game_setting.characters
  end

end
