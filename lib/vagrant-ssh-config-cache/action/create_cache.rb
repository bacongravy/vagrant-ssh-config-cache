class VagrantPlugins::SSHConfigCache::Action::CreateCache

  def initialize(app, env)
    @app = app
  end

  def call(env)
    @app.call(env)
    env[:ui].info "Caching ssh-config..."
  end

end
