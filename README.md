# pkg(8) - a wrapper around package managers

Status: experimental


## Installation

    $ wget https://raw.githubusercontent.com/vinc/pkg/master/pkg.sh
    $ sudo cp pkg.sh /usr/local/bin/pkg
    $ sudo chmod a+x /usr/local/bin/pkg


## Usage

### With system package managers

Let say you use Arch Linux on your local computer and Debian on a remote server.
You would type `pacman -Ss foo` on the former to search a package named `foo` 
and `apt search foo` or `apt-cache search foo` on the latter.

And you would type `sudo pacman -S foo` to install it on Arch and
`sudo apt install foo` or `sudo apt-get install foo` on Debian.

With `pkg` you can search a package on both systems with:

    $ pkg search foo

And install it with:

    $ pkg install foo

Or you could even type `pkg s foo` and `pkg i foo` to save a few keystrokes.

### With language package managers

You may use some language package managers, like `npm` or `pip`, in addition
to the system one. No worries, `pkg` go you covered:

    $ pkg --with npm install foo

With `pkg` you won't have to remember to type `npm uninstall foo` with `npm`
but `yarn remove foo` with `yarn`, or `sudo pacman -R foo` on Arch Linux but
`sudo apt remove foo` on Ubuntu. Just type the most obvious command and it
will get corrected or passed on.


License
-------

Copyright (c) 2017 Vincent Ollivier. Released under MIT.
