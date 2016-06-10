#!/sbin/busybox sh


# Mount root as RW to apply tweaks and settings
mount -o remount,rw /;
mount -o rw,remount /system


# Install Busybox
/sbin/bb/busybox --install -s /sbin


# Neon Kernel!!
echo "Neon Boot Script Started" | tee /dev/kmsg


# MSM_Hotplug Settings
stop mpdecision
echo 1 > /sys/module/msm_hotplug/msm_enabled
echo 1 > /sys/module/msm_hotplug/min_cpus_online
echo 500 > /sys/module/msm_hotplug/down_lock_duration
echo 2500 > /sys/module/msm_hotplug/boost_lock_duration
echo 200 5:100 50:50 350:200 > /sys/module/msm_hotplug/update_rates
echo 100 > /sys/module/msm_hotplug/fast_lane_load
echo 2 > /sys/module/msm_hotplug/max_cpus_online_susp


# Intelli_Plug Settings
#stop mpdecision
#echo 1 > /sys/module/intelli_plug/parameters/intelli_plug_active
#echo 787200 > /sys/module/intelli_plug/parameters/screen_off_max


# Kcal Settings
echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo 256 256 256 > /sys/devices/platform/kcal_ctrl.0/kcal
echo 35 > /sys/devices/platform/kcal_ctrl.0/kcal_min
echo 1 > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_invert
echo 275 > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo 251 > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo 258 > /sys/devices/platform/kcal_ctrl.0/kcal_cont


# VM tuning
echo 5 > /proc/sys/vm/dirty_background_ratio
echo 10 > /proc/sys/vm/dirty_ratio
echo 3 > /proc/sys/vm/page-cluster
echo 3000 > /proc/sys/vm/dirty_expire_centisecs
echo 500 > /proc/sys/vm/dirty_writeback_centisecs
echo 50 > /proc/sys/vm/vfs_cache_pressure
echo 1 > /proc/sys/vm/overcommit_memory


# Power Mode
echo 1 > /sys/module/msm_pm/modes/cpu0/retention/idle_enabled
echo 1 > /sys/module/msm_pm/modes/cpu1/retention/idle_enabled
echo 1 > /sys/module/msm_pm/modes/cpu2/retention/idle_enabled
echo 1 > /sys/module/msm_pm/modes/cpu3/retention/idle_enabled


# ZRAM
#echo 4 > /sys/block/zram0/max_comp_stream


# Tune entropy parameters.
echo 512 > /proc/sys/kernel/random/read_wakeup_threshold
echo 256 > /proc/sys/kernel/random/write_wakeup_threshold


# Native D2W
echo 0 > /sys/bus/i2c/drivers/ft5x06_i2c/5-0038/d2w_switch


# State Notifer
echo 1 > /sys/kernel/state_helper/enabled


# Init.d Support
/sbin/bb/busybox run-parts /system/etc/init.d


# Google Services battery drain fixer by Alcolawl@xda
pm enable com.google.android.gms/.update.SystemUpdateActivity
pm enable com.google.android.gms/.update.SystemUpdateService
pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver
pm enable com.google.android.gms/.update.SystemUpdateService$Receiver
pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver
pm enable com.google.android.gsf/.update.SystemUpdateActivity
pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity
pm enable com.google.android.gsf/.update.SystemUpdateService
pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver
pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver


# Neon Kernel!!
echo "Neon Boot Script Completed!" | tee /dev/kmsg
