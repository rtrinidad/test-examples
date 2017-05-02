#!/bin/bash

if [ "$JBOSS_PASS" = "**Random**" ]; then
    unset JBOSS_PASS
fi

if [ ! -f /.jboss_admin_pass_configured ]; then
    /opt/set_jboss_admin_pass.sh
fi

exec $JBOSS_HOME/bin/standalone.sh -b=0.0.0.0
