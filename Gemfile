source "https://rubygems.org"
source "http://gems.hashicorp.com"

require 'fileutils'

embedded_location = '/opt/vagrant/embedded'

ENV['VAGRANT_INSTALLER_EMBEDDED_DIR'] = embedded_location if File.directory?(embedded_location)

unless ENV.key?('VAGRANT_INSTALLER_EMBEDDED_DIR')
  $stderr.puts "Couldn't find a packaged install of vagrant, and we need this"
  $stderr.puts 'in order to make use of the RubyEncoder libraries.'
  $stderr.puts 'I looked in: ' + embedded_location
end

group :plugins do
  gemspec
end

group :development do
  gem "vagrant", git: "https://github.com/mitchellh/vagrant.git"

  fusion_gem  = Gem::Specification.find_by_name('vagrant-vmware-fusion')
  fusion_path = fusion_gem.gem_dir
  fusion_license_path = File.join(fusion_path, 'license-vagrant-vmware-fusion.lic')
  fusion_license_vagrantd_path = File.join(ENV['HOME'], '.vagrant.d', 'license-vagrant-vmware-fusion.lic')

  rgloader_local_path = File.join(fusion_path, 'rgloader')
  rgloader_embedded_path = File.join(ENV['VAGRANT_INSTALLER_EMBEDDED_DIR'], 'rgloader')

  unless File.symlink?(rgloader_local_path)
    $stderr.puts "Linking local 'rgloader' file to embedded installer"
    FileUtils.ln_s(rgloader_embedded_path, rgloader_local_path)
  end

  unless File.symlink?(fusion_license_path)
    $stderr.puts 'Linking your license file for vmware plugin'
    FileUtils.ln_s(fusion_license_vagrantd_path, fusion_license_path)
  end

end
