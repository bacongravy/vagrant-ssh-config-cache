# vagrant-ssh-config-cache

`vagrant-ssh-config-cache` is a [Vagrant](http://vagrantup.com) plugin for caching the ssh-config of running boxes. It automatically caches the ssh-config of machines anytime they are brought up, and removes the caches when the machines are halted or destroyed.

Caches for each machine are stored at `.vagrant/machines/<name>/ssh-config-cache`. The content each cache file is a valid command-line invocation of ssh.

## Installation

Use `vagrant plugin` to install the gem in your Vagrant environment:

```bash
$ vagrant plugin install vagrant-ssh-config-cache
```

## Usage

```bash
$ vagrant ssh-config-cache -h
Usage: vagrant ssh-config-cache <command> [<args>]

Available subcommands:
     reset
     update

$ vagrant ssh-config-cache reset -h
Usage: vagrant ssh-config-cache reset [target...]

$ vagrant ssh-config-cache update -h
Usage: vagrant ssh-config-cache update [target...]
```

## Example

Update the caches for all machines and then connect to the machine named 'default' using the cached ssh config:

```bash
$ vagrant ssh-config-cache update
$ source .vagrant/machines/default/ssh-config-cache
```

## Development

You can test with a vendored Vagrant:

```bash
$ bin/setup
$ bundle exec vagrant ssh-config-cache
```

...or by building and installing the gem into the system Vagrant:

```bash
$ bundle exec rake build
$ vagrant plugin uninstall vagrant-ssh-config-cache
$ vagrant plugin install pkg/vagrant-ssh-config-cache-*.gem
$ vagrant ssh-config-cache -h
```

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bacongravy/vagrant-ssh-config-cache.
