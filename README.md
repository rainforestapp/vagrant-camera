# Vagrant::Camera

Takes screenshots of your Vagrant VMs.

Inspired by [latortuga/vagrant-screenshot](https://github.com/latortuga/vagrant-screenshot)

## Dependencies

- Virtual Box Provider and VM

## Installation

Install them gem

    $ gem install vagrant-camera

Add this line to your application's Vagrantfile:

    require 'vagrant/camera'

Or install as a global vagrant plugin

    $ vagrant plugin install vagrant-camera

## Usage

    Usage: vagrant camera [vm-name] [options] [-h]
    -o, --open                       Open generated image after capture
    -s, --save PATH                  Save images to a specific directory.
    -h, --help                       Print this help

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licensing

Copyright (c) 2013 Kelly Becker, CLDRDR Inc

MIT License, see LICENSE.txt for more details.
