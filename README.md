# vagrant-ssh-config-cache

`vagrant-ssh-config-cache` is a [Vagrant](http://vagrantup.com) plugin for caching the ssh-config of running boxes. It automatically caches the ssh-config of machines anytime they are brought up, and removes the caches when the machines are halted or destroyed.

Caches for each machine are stored at `.vagrant/machines/<name>/ssh-config-cache`. The content each cache file is a valid command-line invocation of ssh.

## Why?


Sometimes you have a Vagrantfile that takes a long time to evaluate. This overhead is incurred every time you run `vagrant ssh`. In a test environment, with a specific Vagrantfile, ssh-config caching was observed to reduce connection times from 16 seconds, to less than one second.

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

## vssh

The following `vssh` bash function can be used in place of invoking `vagrant ssh <target>`:

```bash
function vssh() {
  if [ $# -eq 0 ]; then
    echo "Error: Please specify a vagrant machine."
    return
  fi
  VAGRANT_MACHINE=$1
  SSH_CONFIG_CACHE_FILE=$PWD/.vagrant/machines/$VAGRANT_MACHINE/ssh-config-cache
  if [ ! -f "$SSH_CONFIG_CACHE_FILE" ]; then
    echo "Notice: The cache for $VAGRANT_MACHINE does not exist. Updating the cache."
    vagrant ssh-config-cache update $VAGRANT_MACHINE
  fi
  if [ -f "$SSH_CONFIG_CACHE_FILE" ]; then
    source $SSH_CONFIG_CACHE_FILE
    if [ $? -eq 255 ]; then
      echo "Error: Unable to connect to the machine. Deleting the cache."
      rm -f $SSH_CONFIG_CACHE_FILE
    fi
  else
    echo "Error: Unable to update the cache for $VAGRANT_MACHINE. Please verify that the machine is running."
  fi
}
```

Example: `$ vssh default`

## Acknowledgements

This project was inspired by [vagrant_ssh_cache](https://github.com/tkishel/vagrant_ssh_cache). This project improves on that one by being a vagrant plugin that updates the cache automatically when the machine is brought up.

Thanks for the idea, Tom!

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
