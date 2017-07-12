class Event < ApplicationRecord
    
    def get_relevant_events
        # the relevant events are those from this user, ordered most recent first.
        relevant = Event.select { |event| event.user_id == user_id }
        relevant = relevant.order(created_at: :desc) # descending order, most recent first
    end
    
    def start_time
        relevant = get_relevant_events
        relevant.all.each do |event|
            if event.command == "start" # the most recent start event
                return event.created_at # time that timer was started
            end
            if event.command == "end" # if there has been an end event since the last start event, timing is off
                return nil # no start time
            end
        end
        return nil # no start time found
    end

end
