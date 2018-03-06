module VagrantPlugins
  module SSHConfigCache
    class Plugin < Vagrant.plugin("2")
      name "vagrant-ssh-config-cache"
      description <<-DESC
      ...
      DESC

      command("ssh-config-cache") do
        require_relative 'command'
        Command
      end
  end
end
