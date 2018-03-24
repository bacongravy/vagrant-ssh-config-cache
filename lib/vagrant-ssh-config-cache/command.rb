class VagrantPlugins::SSHConfigCache::Command < Vagrant.plugin('2', :command)

  require_relative 'command/helpers'
  include Helpers

  def initialize(argv, env)
    @argv     = argv
    @env      = env
    @cmd_name = 'ssh-config-cache'

    split_argv
    register_subcommands
  end

  def execute
    invoke_subcommand
  end

  private

  def register_subcommands
    @subcommands = Vagrant::Registry.new

    @subcommands.register('update') do
      require_relative 'command/update'
      Update
    end

    @subcommands.register('reset') do
      require_relative 'command/reset'
      Reset
    end
  end

end
