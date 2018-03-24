class VagrantPlugins::SSHConfigCache::Action::RemoveCache

  def initialize(app, env)
    @app = app
  end

  def call(env)
    remove_cache(env[:machine])
    @app.call(env)
  end

  private

  def remove_cache(machine)
    ssh_config_cache_file = machine.data_dir.to_s + '/../ssh-config-cache'
    if File.exist?(ssh_config_cache_file)
      machine.ui.info "Removing ssh-config cache..."
      File.delete(ssh_config_cache_file)
    end

  end
end
