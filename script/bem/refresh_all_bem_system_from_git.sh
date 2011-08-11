#!/bin/bash

# this needs to be first because it will
# do these in order on production
# git add .
# git commit -am "a timestamped message"
# git push origin master
cap production refresh:server_system_update

# only one of the three is needed because they all share(via symbolic links)
# the same nt_system folder on the same machine 
cap staging    refresh:server_system_update
#cap sandbox    refresh:server_system_update
#cap demo       refresh:server_system_update

