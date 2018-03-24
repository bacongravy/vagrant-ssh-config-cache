# [WIP] vagrant-ssh-config-cache

`vagrant-ssh-config-cache` is a [Vagrant](http://vagrantup.com) plugin for caching the ssh-config of running boxes. It automatically caches the ssh-config of machines anytime they are brought up, and removes the caches when the machines are halted or destroyed.

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

```bash
$ vagrant ssh-config-cache reset
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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bacongravy/vagrant-ssh-config-cache.
