## About this overlay ##

This is my gentoo overlay which contains several useful(?) modifications to some packages and several script collections hosted here as well as sub-repositories.

# Script collections #
Scripts, I have written over the years and which I tend to miss on the (A|Lin|Un)ix machines I am working on. The scripts are grouped in collections (sub-repositories):
  * [Evergreens](http://code.google.com/p/cj-overlay/source/browse/?repo=evergreens) - Christoph's very useful scripts, including:
    * [cwdiff](http://code.google.com/p/cj-overlay/source/browse/cwdiff?repo=evergreens), which wraps wdiff to support directories and colorize the output (available as [tarball](https://code.google.com/p/cj-overlay/downloads/list) and in [MacPorts](http://www.macports.org/ports.php?by=name&substr=cwdiff), [Arch](https://aur.archlinux.org/packages/cwdiff), [NetBSD](http://cvsweb.netbsd.org/bsdweb.cgi/pkgsrc/textproc/cwdiff/) and [Gentoo Linux](http://packages.gentoo.org/package/dev-util/cwdiff))
  * [Job-tools](http://code.google.com/p/cj-overlay/source/browse/?repo=job-tools) - Scripts to handle simulation jobs, including:
    * [q2start](http://code.google.com/p/cj-overlay/source/browse/q2start?repo=job-tools&name=mpip), a submit script generator for SGE
    * [llstart](http://code.google.com/p/cj-overlay/source/browse/llstart?repo=job-tools&name=mpip), a submit script generator for IBM's load leveler
    * [lstart](http://code.google.com/p/cj-overlay/source/browse/lstart?repo=job-tools&name=lanl), a minimal job manager written in bash for clusters without a queueing system
    * [mstart](http://code.google.com/p/cj-overlay/source/browse/mstart?repo=job-tools&name=lanl), a submit script generator for Moab
  * [Sci-scripts](http://code.google.com/p/cj-overlay/source/browse/?repo=sci-scripts) - Scripts for scientific purposes

## How to add this overlay ##

```
layman -a cj-overlay
```
Overlay will be added, do not forget to add
```
source /var/lib/layman/make.conf
```
to your `/etc/portage/make.conf`