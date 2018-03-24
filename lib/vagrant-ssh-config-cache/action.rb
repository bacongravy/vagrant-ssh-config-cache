require 'vagrant/action/builder'

module VagrantPlugins::SSHConfigCache::Action

  def self.action_create_cache
    require_relative 'action/create_cache'
    Vagrant::Action::Builder.new.tap do |b|
      b.use CreateCache
    end
  end

  def self.action_remove_cache
    require_relative 'action/remove_cache'
    Vagrant::Action::Builder.new.tap do |b|
      b.use RemoveCache
    end
  end

end
