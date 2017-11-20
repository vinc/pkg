# pkg(1) -- a wrapper around package managers

Status: unstable


## Installation

    $ git clone git://github.com/vinc/pkg.git
    $ cd pkg
    $ sudo cp pkg.sh /usr/local/bin/pkg
    $ sudo chmod a+x /usr/local/bin/pkg


## Usage

Let say you use Arch Linux on your local computer and Ubuntu on a remote server.
To search a package named `foo` you would type `pacman -Ss foo` on the former
and `sudo apt search foo` on the latter.

And you would type `sudo pacman -S foo` or `sudo apt install foo` to install it.

Not so long ago on Debian systems you would have typed `apt-cache search foo`
and `sudo apt-get install foo`.

With `pkg` you can search a package on both systems with:

    $ pkg search foo

And install it with:

    $ pkg install foo

Or you could even type `pkg s foo` and `pkg i foo` to save a few keystrokes.

You may use some language package managers in addition to the system one, like
`npm` or `pip`, no worries:

    $ pkg --with npm install foo

With `pkg` you won't have to remember to type `npm uninstall foo` with `npm`
but `yarn remove foo` with `yarn`, or `sudo pacman -R foo` on Arch Linux but
`sudo apt remove foo` on Ubuntu. Just type the most obvious command and it
will get corrected or passed on.


License
-------

Copyright (c) 2017 Vincent Ollivier. Released under MIT.
