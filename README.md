# README

## Slacktime
Slacktime is a plugin for [Slack](https://slack.com/) that allows the user to set and clear
timers.

### Usage
When logged in to slack:

* `/slacktime start`: This starts the timer.
* `/slacktime`: (with no argument) This prints out the elapsed time since the timer was started.
* `/slacktime end`: This clears the timer.

### Installing and Running

* Clone [Slacktime](https://github.com/DarylMcCullough/slacktime)
* Copy the file `config/application.example` into `config/application.yml`
* Fill in the value of environment variable `SLACK_SLASH_COMMAND_TOKEN` with the verification token for `Slacktime` (you can receive this via email from stevendaryl3016@yahoo.com)
* Run rails with the appropriate IP and HOST.

### Dependencies
This service was written using
* rails 5.1.2
* ruby 2.4.1
* figaro (for handling environmental variables)
* sidekiq (for receiving http requests)
* httparty (for posting http requests)
* puma (for creating a web service)

### Important files

* `config/application.yml`: Contains reference to slack verification token
* `app/models/event.rb`: Model for events (corresponding to a user-issued slacktime command)
* `app/controllers/commands_controller.rb`: Handles `post create` http requests from Slack (for each slacktime command)
* `lib/command_worker.rb`: contains the logic for responding to commands_controller
