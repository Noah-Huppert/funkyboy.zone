#!/usr/bin/env bash
#?
# cron-run.sh - Run backup.sh
# 
# USAGE
#
#	cron-run.sh OPTIONS...
#
# OPTIONS
#
#	OPTIONS...    Any options provided will be passed to the script
#
#?

{{ pillar.backup.script }} \
	-s {{ pillar.backup.space }} \
	-c {{ pillar.backup.s3cmd_config }} \
	-r {{ pillar.backup.success_status_file }} \
	{% for f in pillar['backup']['backup_targets'] %} -b {{ f }} {% endfor %} \
	{% for f in pillar['backup']['backup_exclude'] %} -e "{{ f }}" {% endfor %} \
	$@ \
2>&1 | vlogger -t {{ pillar.backup.log_tag }}