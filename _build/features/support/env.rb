require 'cucumber-api'
require 'minke'

discovery = Minke::Docker::ServiceDiscovery.new ENV['DOCKER_PROJECT'], Minke::Docker::DockerRunner.new, ENV['DOCKER_NETWORK']
$SERVER_PATH = "http://#{discovery.bridge_address_for 'kittertray', '8001'}"

Before do |scenario|

end

After do |scenario|

end
