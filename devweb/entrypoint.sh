#!/bin/bash

echo Hello Tiger!!!

# Conditional logic/tasks for first start, should work both for restarts and rebuild!
# If necessary this can be another script file referenced from here e.g. /usr/local/bin/firststart.sh (Make sure you copy this file from host to docker container in the dockerfile)

# Any other logic/tasks

# Start the web server in the end(your forground process)
/usr/sbin/httpd -DFOREGROUND
