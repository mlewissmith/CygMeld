MELD for CYGWIN
===============

https://github.com/GNOME/meld
https://git.gnome.org/browse/meld/

INSTALLING
----------

Download latest release from `https://github.com/mlewissmith/CygMeld/releases`

Run self-extracting tarball


UNINSTALLING
------------

**COPY** the uninstall script into `/tmp`.  Edit the header and remove the `exit 1` line.

    cp /etc/uninstall/meld-X.X.X-uninstall.sh /tmp
    vi /tmp/meld-X.X.X-uninstall.sh # edit header
    /tmp/meld-X.X.X-uninstall.sh


BUILDING FROM SOURCE
--------------------
* Clone this repository
  git clone https://github.com/mlewissmith/CygMeld.git
* Update submodule(s)
  cd CygMeld
  git submodule update
* Run buildscript
  ./build.sh

... creates self-extracting tarball.  Run it.
