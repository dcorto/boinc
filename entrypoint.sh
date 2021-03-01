#!/bin/bash

if [ -z "${CC_CONFIG_OPTIONS_NO_GPUS}" ]; then
  CC_CONFIG_OPTIONS_NO_GPUS=1
fi

# parse cc_config.xml
cp /tmp/cc_config.xml /tmp/cc_config.xml.dist
sed -i 's/__CC_CONFIG_OPTIONS_NO_GPUS__/'${CC_CONFIG_OPTIONS_NO_GPUS}'/g' /tmp/cc_config.xml.dist
mv /tmp/cc_config.xml.dist /opt/boinc/cc_config.xml

# parse global_prefs_override.xml
cp /tmp/global_prefs_override.xml /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_RUN_ON_BATTERIES__/'${GP_RUN_ON_BATTERIES}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_RUN_USER_ACTIVE__/'${GP_RUN_USER_ACTIVE}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_RUN_GPU_USER_ACTIVE__/'${GP_RUN_GPU_USER_ACTIVE}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_LEAVE_APPS_MEMORY__/'${GP_LEAVE_APPS_MEMORY}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_SUSPEND_CPU_USAGE__/'${GP_SUSPEND_CPU_USAGE}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_MAX_NCPUS_PCT__/'${GP_MAX_NCPUS_PCT}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_CPU_USAGE_LIMIT__/'${GP_CPU_USAGE_LIMIT}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_CPU_SCHEDULING_PERIOD_MINUTES__/'${GP_CPU_SCHEDULING_PERIOD_MINUTES}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_DISK_INTERVAL__/'${GP_DISK_INTERVAL}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_DISK_MAX_USED_GB__/'${GP_DISK_MAX_USED_GB}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_DISK_MAX_USED_PCT__/'${GP_DISK_MAX_USED_PCT}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_RAM_MAX_USED_BUSY_PCT__/'${GP_RAM_MAX_USED_BUSY_PCT}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_RAM_MAX_USED_IDLE_PCT__/'${GP_RAM_MAX_USED_IDLE_PCT}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_MAX_BYTES_SEC_UP__/'${GP_MAX_BYTES_SEC_UP}'/g' /tmp/global_prefs_override.xml.dist
sed -i 's/__GP_MAX_BYTES_SEC_DOWN__/'${GP_MAX_BYTES_SEC_DOWN}'/g' /tmp/global_prefs_override.xml.dist
mv /tmp/global_prefs_override.xml.dist /opt/boinc/global_prefs_override.xml

# set remote hosts rpc
if [ -z "${REMOTE_HOSTS}" ]; then
  if [ -f /opt/boinc/remote_hosts.cfg ]; then
    rm /opt/boinc/remote_hosts.cfg
  fi
else
  touch /tmp/remote_hosts.cfg
  IFS=',' read -ra HOSTS <<< "${REMOTE_HOSTS}"
  for i in "${HOSTS[@]}"; do
      echo $i >> /tmp/remote_hosts.cfg
  done
  mv /tmp/remote_hosts.cfg /opt/boinc/remote_hosts.cfg
fi

# set remote auth rpc
if [ -z "${REMOTE_AUTH}" ]; then
  if [ -f /opt/boinc/gui_rpc_auth.cfg ]; then
    rm /opt/boinc/gui_rpc_auth.cfg
  fi
else
  echo ${REMOTE_AUTH} > /opt/boinc/gui_rpc_auth.cfg
fi

# Run boinc
exec /usr/bin/boinc
