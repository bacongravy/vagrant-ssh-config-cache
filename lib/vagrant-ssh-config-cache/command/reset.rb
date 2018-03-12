class VagrantPlugins::SSHConfigCache::Command::Reset < Vagrant.plugin('2', :command)
  def execute
    options = {}

    opts = OptionParser.new do |o|
      o.banner = "Usage: vagrant ssh-config-cache reset [target]"
    end

    @argv.shift

    argv = parse_options(opts)
    return if !argv

    reset_config_cache(argv)
  end

  private

  def reset_config_cache(target)
    with_target_vms(target) do |machine|
      ssh_config_cache_file = machine.data_dir.to_s + '/../ssh-config-cache'
      if File.exist?(ssh_config_cache_file)
        @env.ui.warn("Deleting file: #{ssh_config_cache_file}")
        File.delete(ssh_config_cache_file)
      end
    end

    0
  end
end
