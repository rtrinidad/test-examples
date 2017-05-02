#!/bin/bash
cd $JBOSS_HOME/standalone/deployments
ln -s /home/opendata/app/target/api.war api.war
/opt/run.sh
