require 'command_worker'
class CommandsController < ApplicationController

  def create
    return render json: {}, status: 403 unless valid_slack_token? # send error if the verification token doesn't match
    CommandWorker.perform_async(command_params.to_h) # send appropriate message
    render json: { response_type: "in_channel" }, status: :created # notify that the event was created
  end

  private

    def valid_slack_token?
      params[:token] == ENV["SLACK_SLASH_COMMAND_TOKEN"] # verification tokens match
    end

    # Only allow a trusted parameter "white list" through.
    def command_params
      params.permit(:text, :token, :user_id, :response_url)
    end

end