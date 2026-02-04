# Boinc on Docker

[![](https://github.com/dcorto/boinc/actions/workflows/main.yml/badge.svg)](https://github.com/dcorto/boinc/actions/workflows/main.yml)

[![](https://img.shields.io/docker/image-size/thedavis/boinc/latest)](https://hub.docker.com/r/thedavis/boinc/latest)
[![](https://img.shields.io/docker/pulls/thedavis/boinc)](https://hub.docker.com/r/thedavis/boinc)

## Motivation

Running [BOINC](https://boinc.berkeley.edu/) is cool, but inside a Docker container is coolest!

## Versions and Docker images

* `1.1.3`, `1.1`, `latest` - [(Dockerfile)](https://github.com/dcorto/boinc/blob/v1.1.3/Dockerfile) - [CHANGELOG](https://github.com/dcorto/boinc/blob/v1.1.3/CHANGELOG.md)

* `1.1.2` - [(Dockerfile)](https://github.com/dcorto/boinc/blob/v1.1.2/Dockerfile) - [CHANGELOG](https://github.com/dcorto/boinc/blob/v1.1.2/CHANGELOG.md)

* `1.1.1` - [(Dockerfile)](https://github.com/dcorto/boinc/blob/v1.1.1/Dockerfile) - [CHANGELOG](https://github.com/dcorto/boinc/blob/v1.1.1/CHANGELOG.md)

* `1.1.0` - [(Dockerfile)](https://github.com/dcorto/boinc/blob/v1.1.0/Dockerfile) - [CHANGELOG](https://github.com/dcorto/boinc/blob/v1.1.0/CHANGELOG.md)

* `1.0.3`, `1.0` - [(Dockerfile)](https://github.com/dcorto/boinc/blob/v1.0.3/Dockerfile) - [CHANGELOG](https://github.com/dcorto/boinc/blob/v1.0.3/CHANGELOG.md)

* `1.0.2` - [(Dockerfile)](https://github.com/dcorto/boinc/blob/v1.0.2/Dockerfile) - [CHANGELOG](https://github.com/dcorto/boinc/blob/v1.0.2/CHANGELOG.md)

* `1.0.1` - [(Dockerfile)](https://github.com/dcorto/boinc/blob/v1.0.1/Dockerfile) - [CHANGELOG](https://github.com/dcorto/boinc/blob/v1.0.1/CHANGELOG.md)

* `1.0.0` - [(Dockerfile)](https://github.com/dcorto/boinc/blob/v1.0.0/Dockerfile) - [CHANGELOG](https://github.com/dcorto/boinc/blob/v1.0.0/CHANGELOG.md)

## Usage

```
$ docker build -t boinc .

$ cp .env.dist .env

$ docker run -d \
  --name boinc \
  -p 31416:31416 \
  --pid=host \
  --env-file=.env \
  -v boinc_data:/opt/boinc \
  boinc

# Attach to a BOINC project:

$ docker exec boinc boinccmd --project_attach <project_url> <token>

```

### With docker-compose

The [`docker-compose.yaml`](docker-compose.yaml) on this repo is a full functional example.

Can you quickly launch your BOINC container with:

```
$ docker-compose up -d
```

## Environment variables supported

### Config client

**CC_*** variables references over `cc_config.xml` file

- CC_CONFIG_OPTIONS_NO_GPUS

- CC_CONFIG_LOG_CPU_SCHED

- CC_CONFIG_LOG_HTTP_DEBUG

- CC_CONFIG_LOG_NETWORK_STATUS_DEBUG

More info about [cc_config.xml](https://boinc.berkeley.edu/wiki/Client_configuration) on the BOINC Wiki

### Preferences override

For each environment variable not set, BOINC will use the value from the project web site or the default one.

**GP_*** variables references over `global_prefs_override.xml` file

- GP_RUN_ON_BATTERIES

  Sets `run_on_batteries` (1 or 0)

- GP_RUN_USER_ACTIVE

  Sets `run_user_active` (1 or 0)

- GP_RUN_GPU_USER_ACTIVE

  Sets `run_gpu_user_active` (1 or 0)

- GP_LEAVE_APPS_MEMORY

  Sets `leave_apps_memory` (1 or 0)

- GP_SUSPEND_CPU_USAGE

  Sets `suspend_cpu_usage` (from 0.000000 to 100.000000)

- GP_MAX_NCPUS_PCT

  Sets `max_ncpus_pct` (from 0.000000 to 100.000000)

- GP_CPU_USAGE_LIMIT

  Sets `cpu_usage_limit` (from 0.000000 to 100.000000)

- GP_CPU_SCHEDULING_PERIOD_MINUTES

  Sets `cpu_scheduling_period_minutes` (number)

- GP_DISK_INTERVAL

  Sets `disk_interval` (number)

- GP_DISK_MAX_USED_GB

  Sets `disk_max_used_gb` (number)

- GP_DISK_MAX_USED_PCT

  Sets `disk_max_used_pct` (from 0.000000 to 100.000000)

- GP_RAM_MAX_USED_BUSY_PCT

  Sets `ram_max_used_busy_pct` (from 0.000000 to 100.000000)

- GP_RAM_MAX_USED_IDLE_PCT

  Sets `ram_max_used_idle_pct` (from 0.000000 to 100.000000)

- GP_MAX_BYTES_SEC_UP

  Sets `max_bytes_sec_up` (number)

- GP_MAX_BYTES_SEC_DOWN

  Sets `max_bytes_sec_down` (number)

More info about [global_prefs_override.xml](https://boinc.berkeley.edu/wiki/Global_prefs_override.xml) on the BOINC Wiki

### Controlling BOINC remotely (GUI RPC)

- REMOTE_HOSTS (string)

  Adds hosts to `remote_hosts.cfg`. Each host/ip must be comma separated

  If `REMOTE_HOSTS` is not set, only localhost access is allowed to RPC

- REMOTE_AUTH (string)

  Sets the remote RPC password (max 250 chars). If not set, on every container run, a new hash will be generated ( see `gui_rpc_auth.cfg` file on data volume)

More info about [Controlling BOINC remotely](https://boinc.berkeley.edu/wiki/Controlling_BOINC_remotely) on the BOINC Wiki.

**Disclaimer:** Not all options / configurations are supported right now.

## Limitations

GPU usage is not supported right now.
