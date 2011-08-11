#!/bin/bash

cap production  refresh:refresh_runner

cap staging refresh:refresh_runner

# we do not refresh the demo server because
# it contains demo/experimental data that 
# we don't want to erase.
