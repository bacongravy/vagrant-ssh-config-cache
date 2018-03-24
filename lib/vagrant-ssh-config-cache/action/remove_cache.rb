class VagrantPlugins::SSHConfigCache::Action::RemoveCache

  def initialize(app, env)
    @app = app
  end

  def call(env)
    @app.call(env)
    env[:ui].info "Removing ssh-config cache..."
  end

end
