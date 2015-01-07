
# Bill's Kitchen

A [DevPack](http://blog.tknerr.de/blog/2014/10/09/devpack-philosophy-aka-works-on-your-machine/) with all you (or Bill Gates would) need for cooking with Chef and Vagrant on Windows, shrink-wrapped in a portable package.

![Bill's Kitchen Screenshot](https://raw.github.com/tknerr/bills-kitchen/master/doc/bills_kitchen_screenshot.png) 

## What's inside?

### Main Tools

The main tools for cooking with Chef / Vagrant:

* [Chef-DK](http://www.getchef.com/downloads/chef-dk/windows/) 0.3.5, with embedded [Ruby](http://rubyinstaller.org/downloads/) 2.0.0
* [DevKit](http://rubyinstaller.org/add-ons/devkit/) 4.7.2
* [Vagrant](http://vagrantup.com/) 1.7.2
* [Terraform](http://terraform.io/) 0.3.5
* [Packer](http://packer.io/) 0.7.5
* [Consul](http://consul.io/) 0.4.1

### Plugins

These plugins are pre-installed:

 * vagrant plugins:
   * [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus) - installs omnibus chef in a vagrant VM
   * [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier) - caches all kinds of packages you intsall in the vagrant VMs
   * [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf) - berkshelf integration for vagrant
   * [vagrant-toplevel-cookbooks](https://github.com/tknerr/vagrant-toplevel-cookbooks) - support for one top-level cookbook per vagrant VM
   * ...use `vagrant install <plugin>` to install more
 * knife plugins (just as an example):
   * [knife-audit](https://github.com/jbz/knife-audit) - keeps track of which cookbooks are used by which node
   * [knife-server](https://github.com/fnichol/knife-server) - sets up and backs uo a chef server
   * ...use `chef gem install <plugin>` to install more

### Supporting Tools

Useful additions for a better cooking experience:

* [ConEmu](https://code.google.com/p/conemu-maximus5/) - a better Windows console with colours, tabs, etc...
* [SublimeText2](http://www.sublimetext.com/) - a better editor (trial version) with additional packages for [Chef](https://github.com/cabeca/SublimeChef) and [Cucumber](https://github.com/npverni/cucumber-sublime2-bundle) installed
* [PortableGit](https://code.google.com/p/msysgit/) - git client for Windows (preconfigured with [kdiff3](http://kdiff3.sourceforge.net/) as diff/merge tool)
* [putty](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) - the SSH client for Windows
* [clink](http://mridgers.github.io/clink/) - command completion and Bash-like line editing for Windows
* [Cygwin](http://www.cygwin.com/)-based `ssh.exe` and `rsync.exe` to make rsync-based Vagrant synced folders work on Windows

### Environmental Changes

The following changes are applied to your environment by running `W:\set-env.bat`:

* Constraining as much as possible to the `W:\` drive:
 * `%HOME%` points to `W:\home`
 * `%VAGRANT_HOME%` points to `W:\home\.vagrant.d`
 * `%PATH%` is preprended with the bin dirs of the tools in `W:\tools\`
 * **exception**: `%VBOX_USER_HOME%` points to `%USERPROFILE%`, i.e. VirtualBox VMs are still stored under `%USERPROFILE%`
* Fixing annoyances:
 * `set TERM=cygwin` to fix vagrant ssh issues
 * `set CYGWIN=nodosfilewarning` to mute vagrant ssh warnings
 * `set ANSICON=true` to get coloured output with Vagrant on Windows
 * `set SSL_CERT_FILE=W:\home\cacert.pem` pointing to recent CA certs avoiding Ruby SSL errors

### Aliases

Registered doskey aliases:

* run `be <command>` for `bundle exec <command>`
* run `vi <file_or_dir>` for `sublime_text <file_or_dir>` 

### Examples

These repositories are used for acceptance-testing the [common usage scenarios](https://github.com/tknerr/vagrant-workflow-tests/blob/master/spec/acceptance/usage_scenarios_spec.rb):

* A [sample-toplevel-cookbook](https://github.com/tknerr/sample-toplevel-cookbook) with all kinds cookbook tests: syntax check, style checks, linting, unit and integration tests
* A [sample-infrastructure-repo](https://github.com/tknerr/sample-infrastructure-repo) which defines a sample server infrastructure with environments and databages via Vagrant / Chef Solo

## Prerequisites

The only requirement for using the devpack is a recent version of [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (couldn't make that one portable).


## Installation

As a prerequisite for building bill's kitchen you need 7zip installed in `C:\Program Files\7-Zip\7z.exe`.

### Building Bill's Kitchen

To build the kitchen (make sure you don't have spaces in the path):
```
$ gem install bundler
$ bundle install
$ rake build
```

This might take a while (you can go fetch a coffee). It will download the external dependencies, install the tools and prepare everything else we need in the kitchen into the `target/build` directory. Finally it runs the `spec/integration` examples to ensure everything is properly installed.

### Running the Acceptance Tests

To run the more comprehensive `spec/acceptance` tests:
```
$ rake acceptance
```

This will use various of the tools in combination by running the main usage scenarios, e.g.:

* cloning a sample top-level cookbook and sample infrastructure repository
* running various commands like `bundle install`, `vagrant plugin install`, `vagrant up`
* running different kinds of cookbook tests via `knife cookbook test`, `foodcritic`, `chefspec` and `test-kitchen`

### Packaging

Finally, if all the tests pass you can create a portable zip package:
```
$ rake package
```

This will and finally package everything in the `target/build` directory into `target/bills-kitchen-<version>.7z`.

### Changing the Mount Drive Letter

By default the Ruby DevPack will be mounted to the `W:\` drive. If you need to change it you only have to update the references in these two files:

* `mount-drive.cmd`
* `unmount-drive.cmd`

## Usage

Make sure you have [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed, then:

1. unzip the `target/bills-kitchen-<version>.7z` somewhere
2. mount the kitchen to the `W:\` drive by double-clicking the `mount-drive.bat` file
3. click `W:\Launch ConEmu.lnk` to open a command prompt
4. in the command prompt run `W:\set-env.bat` to set up the environment
5. start hacking!

## Acknowledgements & Licensing

Bill's Kitchen bundles lots of awesome Open Source software. The copyright owners of this software are mentioned here. For a full-text version of the licenses mentioned above please have a look in the `tools` directory where the respective software is installed.

* Vagrant - Copyright (c) 2010-2014 Mitchell Hashimoto (MIT license)
* ChefDK - Copyright (c) 2014 Chef Software (Apache 2.0 license)
* ConEmu - Copyright (c) 2006-2008 Zoin <zoinen@gmail.com>, 2009-2013 Maximus5 <ConEmu.Maximus5@gmail.com> (BSD 3-Clause license)
* clink - Copyright (c) 2012-2014 Martin Ridgers (MIT license), 1994–2012 Lua.org, PUC-Rio (GPLv3)
* PortableGit - by msysGit team (GPLv2 license)
* DevKit - Copyright (c), 2007-2014 RubyInstaller Team (BSD 3-Clause license)
* kdiff3 - Copyright (c) 2002-2012 Joachim Eibl (GPLv2 license)
* putty - Copyright (c) 1997-2014 Simon Tatham (MIT license)
* rsync - Copyright (c) 1996-2011 by Andrew Tridgell, Wayne Davison, and others. (GPLv3)
* OpenSSH - multiple licenses and copyright holders (OpenSSH License, BSD-compatible)

It also includes an evaluation copy of the awesome [Sublime Text 2](http://www.sublimetext.com/) editor. Please use it for evaluation purposes only (no commercial usage) or [buy a license](http://www.sublimetext.com/buy) if you like it! 

Bill's Kitchen itself is published under the MIT license. It is not "derivative work" but rather ["mere aggregation"](https://www.gnu.org/licenses/gpl-faq.html#MereAggregation) of other software and thus does not need to be licensed under GPL itself.
