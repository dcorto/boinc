# CHANGELOG

## v1.0.3 - 14-03-2021

* Use `ppa:costamagnagianfranco/boinc` for install boinc-client

* New log flags environment variables:
  * CC_CONFIG_LOG_CPU_SCHED
  * CC_CONFIG_LOG_HTTP_DEBUG
  * CC_CONFIG_LOG_NETWORK_STATUS_DEBUG

## v1.0.2 - 08-03-2021

* Change image from debian to ubuntu (fixes SSL bug on armhf builds with QEMU)

* Update DockerHub description on push

## v1.0.1 - 04-03-2021

* Fix SSL problem connecting to https://www.worldcommunitygrid.org/ caused by "outdated" `ca-certificates` package

## v1.0.0 - 02-03-2021

* Initial release
