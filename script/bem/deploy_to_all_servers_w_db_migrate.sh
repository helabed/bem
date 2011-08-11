#!/bin/bash


cap staging deploy
cap staging deploy:migrate

cap production deploy
cap production deploy:migrate

