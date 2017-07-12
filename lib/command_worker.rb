class CommandWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(params) # responds to a post create command with the given parameters
    command = params[:text] # when a user types /slacktime cmd, the parameter :txt is bound to cmd (may be empty or nil)
    if command.strip == "" # replace white space by nil--means no command
      command = nil
    end
    
    event = Event.new(command: command, user_id: params[:user_id])
    event.save
    
    if event.command == "start" #start timer
      text = "Start timing..."
    elsif event.command == "end" #clear timer
      text = "End timing..."
    elsif ! event.command # no command means display time since start
      if event.start_time # if the timer has started
        text = "You have been active for #{time_ago_in_words(event.start_time)}"
      else # if the timer has not started
        text = "Timing is not started..."
      end
    else
      text = "Unknown option: '#{event.command}'" # any other command
    end
    
    message = {
      text: text,
      response_type: "in_channel"
    }

    HTTParty.post(
      params[:response_url], { # response_url is the url to post response to at Slack
        body: message.to_json, 
        headers: {
          "Content-Type" => "application/json"
        }
      }
    )
  end
end