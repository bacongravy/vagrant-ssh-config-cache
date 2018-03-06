module VagrantPlugins
  module SSHConfigCache

    begin
      require 'vagrant'
    rescue LoadError
      raise 'The vagrant-ssh-config-cache plugin must be run within Vagrant.'
    end

    require 'vagrant-ssh-config-cache/plugin'

  end
end
