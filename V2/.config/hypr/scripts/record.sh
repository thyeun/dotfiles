# $HOME/scripts/toggle-screen-recording.sh
# ------------------------------------------

#!/bin/bash 
pid=`pgrep wf-recorder`
status=$?

if [ $status != 0 ] 
then 
  wf-recorder --audio=alsa_output.pci-0000_08_00.6.analog-stereo.monitor --file=$(xdg-user-dir VIDEOS)/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
else 
  pkill --signal SIGINT wf-recorder
fi;
