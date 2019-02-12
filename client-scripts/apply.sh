#!/usr/bin/env bash
#?
# apply.sh - Apply Salt states to server
#
# USAGE
#
#	apply.sh [-u USER] [-h HOST] [-n] [-t]
#
# OPTIONS
#
#	-u USER    (Optional) User with which to access server, defaults to
#	           current user
#	-h HOST    (Optional) Host with which to access server, defaults 
#	           to funkyboy.zone
#	-n         Do not chown uploaded folders to Salt group
#	-t         Run Salt state.apply in test mode
#
# BEHAVIOR
#
#	Applies Salt states to the server
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Get script directory
prog_dir=$(realpath $(dirname "$0"))

# {{{1 Arguments
while getopts "u:h:nt" opt; do
	case "$opt" in
		u)
			user="$OPTARG"
			;;

		h)
			host="$OPTARG"
			;;

		n)
			no_chown="true"
			;;

		t)
			salt_test="true"
			;;

		'?')
			show-help "$0"
			exit 1
			;;
	esac
done

if [ -z "$user" ]; then
	user="$USER"
fi

if [ -z "$host" ]; then
	host="funkyboy.zone"
fi

address="$user@$host"

# {{{1 Upload files
echo "===== Uploading files"

if [ ! -z "$no_chown" ]; then
	upload_args="-n"
fi

if ! "$prog_dir"/upload.sh -u "$user" -h "$host" $upload_args; then
	echo "Error: Failed to upload files" >&2
	exit 1
fi

# {{{1 Apply salt
echo "===== Applying Salt states"

if [ ! -z "$salt_test" ]; then
	salt_post_args="$salt_post_args test=true"
fi

if ! ssh "$address" "sudo salt-call --local --force-color state.apply $salt_post_args"; then
	echo "Error: Failed to apply Salt states" >&2
	exit 1
fi

echo "Done"
