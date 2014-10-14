MELD for CYGWIN
===============

* https://github.com/GNOME/meld
* https://git.gnome.org/browse/meld/

INSTALLING
----------

Download latest release from `https://github.com/mlewissmith/CygMeld/releases`

Run self-extracting tarball.


UNINSTALLING
------------

Uninstall script lives in `/etc/uninstall/meld-X.X.X-uninstall.sh`.


BUILDING FROM SOURCE
--------------------
* Clone this repository
```
  $ git clone https://github.com/mlewissmith/CygMeld.git
```
* Update submodule(s)
```
  $ cd CygMeld
  $ git submodule update
```
* Run buildscript
```
  $ ./build.sh
```
... creates self-extracting tarball.  Run it.
