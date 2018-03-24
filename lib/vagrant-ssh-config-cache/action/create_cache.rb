class VagrantPlugins::SSHConfigCache::Action::CreateCache

  def initialize(app, env)
    @app = app
  end

  def call(env)
    create_cache(env[:machine])
    @app.call(env)
  end

  private

  def create_cache(machine)
    ssh_info = machine.ssh_info
    unless ssh_info.nil?
      ssh_config_cache_file = machine.data_dir.to_s + '/../ssh-config-cache'
      if File.exist?(ssh_config_cache_file)
        machine.ui.info "Updating ssh-config cache..."
      else
        machine.ui.info "Creating ssh-config cache..."
      end
      command_array = %W[ ssh #{ssh_info[:username]}@#{ssh_info[:host]}
                              -p #{ssh_info[:port]}
                              -i #{ssh_info[:private_key_path][0]}
                              -o UserKnownHostsFile=/dev/null
                              -o StrictHostKeyChecking=no
                              -q
                       ]
      command = command_array.shelljoin.gsub('\=', '=')
      File.open(ssh_config_cache_file, 'w') { |file| file.write(command) }
    end
  end

end
