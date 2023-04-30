#!/bin/bash

# Serveral logging levels inspired by python's logging feature

warn() { echo -e "[\e[33mWARN\e[0m]:  \e[1m$*\e[0m"; }
error() { echo -e "[\e[31mERROR\e[0m]: \e[1m$*\e[0m"; }
info() { echo -e "[\e[96mINFO\e[0m]:  \e[1m$*\e[0m"; }
debug() { echo -e "[\e[32mDEBUG\e[0m]: \e[1m$*\e[0m"; }
