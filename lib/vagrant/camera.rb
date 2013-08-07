require "vagrant"
require "vagrant/camera/version"

module Vagrant
  module Camera
    class Camera < Vagrant.plugin("2")
      name "Vagrant Camera"

      command "camera" do
        require_relative "camera/command"
        Command
      end
    end
  end
end
