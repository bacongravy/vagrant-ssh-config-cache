class VagrantPlugins::SSHConfigCache::Command::Reset < Vagrant.plugin('2', :command)
  def execute
    options = {}

    opts = OptionParser.new do |o|
      o.banner = "Usage: vagrant ssh-config-cache reset [target...]"
    end

    @argv.shift

    argv = parse_options(opts)
    return if !argv

    with_target_vms(argv) do |machine|
      require_relative '../action'
      @env.action_runner.run(VagrantPlugins::SSHConfigCache::Action.action_remove_cache, :machine => machine)
    end

    0
  end

end
