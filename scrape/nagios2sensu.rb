#!/opt/sensu/embedded/bin/ruby
require 'amqp'
require 'json'

EventMachine.run do
  timer = EventMachine::PeriodicTimer.new(60) do
#  puts "the time is #{Time.now}"
#  timer.cancel if (n+=1) > 5

    puts "#{Time.now}: Submitting checks..."
    services = JSON.parse(File.read("status.json"))
    services = services["status"]["service_status"]

    connection = AMQP.connect(:host => 'localhost', :user => 'sensu', :password => 'password', :vhost => 'sensu')
    channel = AMQP::Channel.new(connection)
    x = channel.direct("keepalives")
    results_x = channel.direct("results")
    hosts = []
    services.each do |service|
      unless hosts.include?(service["host_name"])
        keepalive = {
          "name" => service["host_name"],
          "address" => "172.28.128.3",
          "bind" => "127.0.0.1",
          "subscriptions" => ["common"],
          "safe_mode" => false,
          "keepalive" => {},
          "version" => "0.16.0",
          "timestamp" => Time.now.to_i
        }

        x.publish keepalive.to_json
        hosts << service["host_name"]
      end

      if service["status"] == "OK"
        status = 0
      elsif service["status"] == "WARNING"
        status = 1
      elsif service["status"] == "CRITICAL"
        status = 2
      else
        status = 3
      end
      
      result = {
        "client" => service["host_name"],
        "check"  => {
          "name"     => service["service_display_name"],
          "status"   => status,
          "issued"   => Time.now.to_i,
          "executed" => Time.now.to_i,
          "output"   => service["status_information"],
        }
      }
      results_x.publish result.to_json
    end

    puts "#{Time.now}: Done submitting checks."
  end
end
