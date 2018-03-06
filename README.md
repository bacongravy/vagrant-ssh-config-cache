# [WIP] vagrant-ssh-config-cache

`vagrant-ssh-config-cache` is a [Vagrant](http://vagrantup.com) plugin for caching the ssh-config of running boxes. It automatically caches the ssh-config of machines anytime they are brought up, and removes the caches when the machines are halted or destroyed. The plugin also provides an `ssh` subcommand which uses the cached ssh-config to ssh into machines.

## Installation

Use `vagrant plugin` to install the gem in your Vagrant environment:

```bash
$ vagrant plugin install vagrant-ssh-config-cache
```

## Usage

```bash
$ vagrant ssh-config-cache -h

Usage: vagrant ssh-config-cache <subcommand> [target]

Subcommands:

        ssh                          Use the cached ssh-config to ssh into the target
        reset                        Discards any ssh-config that may already be cached in the environment

Options:

    -h, --help                       Print this help
```

## Example

```bash
$ vagrant ssh-config-cache reset
```

## Development

```bash
$ bin/setup
$ bundle exec vagrant ssh-config-cache
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bacongravy/vagrant-ssh-config-cache.
