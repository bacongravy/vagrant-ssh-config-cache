class VagrantPlugins::SSHConfigCache::Plugin < Vagrant.plugin("2")

  name "vagrant-ssh-config-cache"
  description <<-DESC
  Caches the ssh-config of running boxes.
  DESC

  command("ssh-config-cache") do
    require_relative 'command'
    VagrantPlugins::SSHConfigCache::Command
  end

  [:machine_action_up].each do |action|
    action_hook("create ssh-config-cache on #{action}", action) do |hook|
      require_relative 'action'
      hook.append(VagrantPlugins::SSHConfigCache::Action.action_create_cache)
    end
  end

  [:machine_action_halt, :machine_action_destroy].each do |action|
    action_hook("remove ssh-config-cache on #{action}", action) do |hook|
      require_relative 'action'
      hook.append(VagrantPlugins::SSHConfigCache::Action.action_remove_cache)
    end
  end

end
