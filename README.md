# Timelapse

Security camera timelapse script

1. Create/update conda environment

~~~
conda env update --file timelapse.yml --prune
~~~
2. Setup youtube credentials as defined [here](https://github.com/tokland/youtube-upload)

3. Save the ``client_secrets.json`` file (but don't commit)

# Description

* ``timelapse_day.sh`` - bash script to combine all images of a given day into a single video
* ``timelapse_month.sh`` - bash script to combine entire month of videos into a single video and upload to youtube
* ``record_timelapse.sh`` - crontab script to record a single frame from both cameras and save as images
* ``record_timelapse_daily.sh`` - crontab script to record image to a separate ``daily`` directory - call once a day

# systemd

[Tutorial](https://opensource.com/article/20/7/systemd-timers)

* Copy `timelapse_month.service` to `/etc/systemd/system/timelapse_month.service`
* Copy `timelapse_month.timer` to `/etc/systemd/system`
* Enable using `systemctl enable timelapse_month.timer`


