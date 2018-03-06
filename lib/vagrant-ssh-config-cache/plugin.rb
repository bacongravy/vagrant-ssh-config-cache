class VagrantPlugins::SSHConfigCache::Plugin < Vagrant.plugin("2")

  name "vagrant-ssh-config-cache"
  description <<-DESC
  ...
  DESC

  command("ssh-config-cache") do
    require_relative 'command'
    VagrantPlugins::SSHConfigCache::Command
  end

end
