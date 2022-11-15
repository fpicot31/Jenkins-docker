#!/bin/bash

cmd=`docker stop $(docker ps -aq) > /dev/null 2>&1`
cmd=`docker rm $(docker ps -aq) > /dev/null 2>&1`
cmd=`docker ps -aq`

if [ -z "$cmd" ]
then
   echo "Plus de containers actifs et inactifs"
else
   echo "Erreur : il rest des containers !"
fi
