[![Build Status](https://travis-ci.org/progapandist/rouble-rate-funbox.svg?branch=master)](https://travis-ci.org/progapandist/rouble-rate-funbox)

## See in action at Heroku
http://rouble-trouble.herokuapp.com/

## Launch on localhost  
1. git clone
2. cd rouble-rate-funbox
3. rails db:create db:migrate db:seed
4. foreman start -f Procfile.dev -p PORT_NUMBER

## Things I used
- Rais/ActiveRecord
- Sidekiq (worker) + Sidetiq (recurrence)
- Pusher (pub-sub)
- Vue.js
- Bootstrap
- Simple Form
- RSpec / Capybara / Factory Girl 
