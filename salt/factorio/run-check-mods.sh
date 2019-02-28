#!/usr/bin/env bash
#?
# run-check-mods-fs.sh - Run check-mods-fs.sh
#
# USAGE
#
#	run-check-mods-fs.sh
#
# BEHAVIOR
#
#	Runs check-mods-fs.sh with correct options.
#
#?

exec {{ pillar.factorio.check_mods_script }} \
	-d {{ pillar.factorio.mods_directory }}
