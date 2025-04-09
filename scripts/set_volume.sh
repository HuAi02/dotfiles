#!/bin/sh

# Retrieve the first ID for the speaker (alsa_output)
SPEAKER_ID=$(wpctl status -n | grep -i 'alsa_output' | grep -oP '\d+' | head -n 1)

# Retrieve the first ID for the microphone (alsa_input)
MICROPHONE_ID=$(wpctl status -n | grep -i 'alsa_input' | grep -oP '\d+' | head -n 1)

# Example of setting the volume for the speaker to 50%
if [ -n "$SPEAKER_ID" ]; then
<<<<<<< HEAD
  wpctl set-volume $SPEAKER_ID 35%
=======
    wpctl set-volume $SPEAKER_ID 25%
>>>>>>> 27162b8 (Sync)
fi

# Example of setting the volume for the microphone to 80%
if [ -n "$MICROPHONE_ID" ]; then
  wpctl set-volume $MICROPHONE_ID 20%
fi
