# Christoph's gentoo overlay

## About this overlay

This is my gentoo overlay which contains several small packages, which I use on multiple machines, but aren't good enough to be moved to the main gentoo tree, yet. 

## How to add this overlay

```
layman -a cj-overlay
```
Overlay will be added, do not forget to add
```
source /var/lib/layman/make.conf
```
to your `/etc/portage/make.conf`


## Issues

Report bugs on the [github issues site](https://github.com/junghans/cj-overlay/issues)


[![Build Status](https://travis-ci.org/junghans/cj-overlay.svg?branch=master)](https://travis-ci.org/junghans/cj-overlay)
