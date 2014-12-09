# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |virtualbox|
    virtualbox.memory = 1024
    virtualbox.cpus = 1
  end

  config.vm.box = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.hiera_config_path = "hiera.yaml"
    puppet.options = "--show_diff"
  end

  config.vm.define "queue" do |rabbitmq|
    rabbitmq.vm.hostname = "queue"
    rabbitmq.vm.network "forwarded_port", guest: 15672, host: 15672, auto_correct: true
    rabbitmq.vm.network "forwarded_port", guest: 5672, host: 5672, auto_correct: true
  end

  config.vm.define "redis" do |redis|
    redis.vm.hostname = "redis"
    redis.vm.network "forwarded_port", guest: 6379, host: 6379, auto_correct: true
  end

  config.vm.define "server" do |server|
    server.vm.hostname = "server"
  end

  config.vm.define "api" do |api|
    api.vm.hostname = "api"
    api.vm.network "forwarded_port", guest: 4567, host: 4567, auto_correct: true
  end

  config.vm.define "dashboard" do |dashboard|
    dashboard.vm.hostname = "dashboard"
    dashboard.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true
  end

  config.vm.define "graphite" do |graphite|
    graphite.vm.hostname = "graphite"
    graphite.vm.network "forwarded_port", guest: 80, host: 4000, auto_correct: true
  end

  config.vm.define "aio" do |aio|
    aio.vm.hostname = "aio"
    aio.vm.network "forwarded_port", guest: 15672, host: 15672, auto_correct: true
    aio.vm.network "forwarded_port", guest: 5672, host: 5672, auto_correct: true
    aio.vm.network "forwarded_port", guest: 6379, host: 6379, auto_correct: true
    aio.vm.network "forwarded_port", guest: 4567, host: 4567, auto_correct: true
    aio.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true
    aio.vm.network "forwarded_port", guest: 80, host: 4000, auto_correct: true

    aio.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 2048
      virtualbox.cpus = 1
    end
  end
end
