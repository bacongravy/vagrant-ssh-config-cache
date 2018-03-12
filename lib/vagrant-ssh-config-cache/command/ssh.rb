require 'shellwords'

class VagrantPlugins::SSHConfigCache::Command::SSH < Vagrant.plugin('2', :command)
  def execute
    options = {}

    opts = OptionParser.new do |o|
      o.banner = "Usage: vagrant ssh-config-cache ssh [target] [-- <ssh-arguments>]"
    end

    @argv.shift

    argv = parse_options(opts)
    return if !argv

    ssh_using_config_cache(argv)
  end

  private

  def ssh_using_config_cache(argv)
    command = nil
    if argv.length > 0 && File.exist?(".vagrant/machines/#{argv[0]}/ssh-config-cache")
      command = File.read(".vagrant/machines/#{argv.shift}/ssh-config-cache")
    else
      target = argv.shift || []
      with_target_vms(target, single_target: true) do |machine|
        ssh_config_cache_file = machine.data_dir.to_s + '/../ssh-config-cache'
        if File.exist?(ssh_config_cache_file)
          @env.ui.warn("Reading from file: #{ssh_config_cache_file}")
          command = File.read(ssh_config_cache_file)
        else
          ssh_info = machine.ssh_info
          raise Vagrant::Errors::SSHNotReady if ssh_info.nil?
          command_array = %W[ ssh #{ssh_info[:username]}@#{ssh_info[:host]}
                                  -p #{ssh_info[:port]}
                                  -i #{ssh_info[:private_key_path][0]}
                                  -o UserKnownHostsFile=/dev/null
                                  -o StrictHostKeyChecking=no
                                  -q
                           ]
          command = command_array.shelljoin
          @env.ui.warn("Writing to file: #{ssh_config_cache_file}")
          File.open(ssh_config_cache_file, 'w') { |file| file.write(command) }
        end
      end
    end
    if command
      command += (" " + argv.shelljoin) if argv.length > 0
      system(command)
    end

    0
  end
end
