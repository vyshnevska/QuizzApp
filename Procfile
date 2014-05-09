redis: redis-server

# faye message's server
faye: rackup faye.ru -s thin -E production

# resque
worker1: rake resque:work QUEUE='*'

# sample Web server for development mode
server: rails s -p 3000