#!/usr/bin/env zsh
#------------------------------------------------------------------------
# Generate a microsite for a region from this site template.
# Run finish-microsite.sh -h to see the required arguments and options.
# Note: This file defaults to use zsh. If you don't have zsh, but you
# DO have bash v5+, then use /path/to/bash finish-microsite.sh.
#
# This script is adapted from the microsite-template's "finish-microsite.sh".
# This version removes options that are not needed for regional chapter 
# sites.
#------------------------------------------------------------------------

script=$0
dir=$(dirname $script)
repo_name=$(basename $PWD)
work_branch=main

ymdtimestamp=$(date +"%Y-%m-%d")
timestamp=$(date +"%Y-%m-%d %H:%M %z")

help() {
	cat << EOF
$script [options] region_name

Only the "region_name" (e.g., "United States of America") is required.

These arguments are optional and used for help and debugging:

-h | --help            Print this message and exit.
-n | --noop            Just print the commands but don't run them.
-s | --next-steps      At the end of running this script to create a new repo,
                       some information about "next steps" is printed. If you want to see
                       this information again, run this script again just using this flag.

** NOTE: use any of these optional arguments BEFORE the region_name!

For example, suppose you want to create a microsite for a USA chapter:

$script United States of America

Whitespace in the name is okay!
EOF
}

next_steps() {
	cat << EOF

Next Steps:

Return to README-template.md for any additional instructions to follow:

  Local copy: README-template.md
  GitHub:     https://github.com/The-AI-Alliance/$repo_name/blob/main/README-template.md

Don't forgot to commit and push any subsequent changes upstream, e.g., "git push --all".

To see these instructions again, run the following command:

  $script --next-steps
EOF
}

error() {
	for arg in "$@"
	do
		echo "ERROR ($script): $arg"
	done
	echo "ERROR: Try: $script --help"
	exit 1
}

warn() {
	for arg in "$@"
	do
		echo "WARN  ($script): $arg"
	done
}

info() {
	for arg in "$@"
	do
		echo "INFO  ($script): $arg"
	done
}


show_next_steps=false
region_name=
while [[ $# -gt 0 ]]
do
	case $1 in
		-h|--h*)
			help
			exit 0
			;;
		-n|--noop)
			NOOP=echo
			;;
		-s|--next-steps)
			show_next_steps=true
			;;
		-*)
			error "Unrecognized argument: $1"
			;;
		*)
			break
			;;
	esac
	shift
done

# The rest of the arguments are considered the regional chapter name:
region_name="$@"

$show_next_steps && next_steps && exit 0

other_files=(
	Makefile
	update-main.sh
	docs/_config.yml
)
markdown_files=($(find docs -name '*.markdown') $(find . -name '*.md'))
html_files=($(find docs/_layouts docs/_includes -name '*.html'))
github_files=($(find .github \( -name '*.yaml' -o -name '*.md' \)))

info "Replacing macros with correct values:"
info "  REGION_NAME:     $region_name"
info "  REPO_NAME:       $repo_name"
info "  YMD_TSTAMP:      $ymdtimestamp"
info "  TIMESTAMP:       $timestamp"
info
info "Note: The microsite URL will be:"
info "  https://the-ai-alliance.github.io/$repo_name/"
info
info "Processing Files:"

for file in "${other_files[@]}" "${markdown_files[@]}" "${html_files[@]}" "${github_files[@]}"
do
	info "  $file"
	if [[ -z $NOOP ]]
	then
		sed -e "s?REPO_NAME?$repo_name?g" \
		    -e "s?REGION_NAME?$region_name?g" \
		    -e "s?YMD_TSTAMP?$ymdtimestamp?g" \
		    -e "s?TIMESTAMP?$timestamp?g" \
		    -i ".back" "$file"
	else
		$NOOP sed ... -i .back $file
	fi
done

info "Delete the backup '*.back' files that were just made."
$NOOP find . -name '*.back' -exec rm {} \;

info "Committing changes to the work branch: $work_branch."
# Use --no-verify to suppress complaints and nonzero exit when
# there is nothing to commit.
$NOOP git commit --no-verify -m "$0: Committing changes after variable substitution." .

info "Pushing all changes upstream to the GitHub repo."
$NOOP git push --all
[[ $status -eq 0 ]] || warn "I could not push the changes back to GitHub." "Try 'git push -all' yourself." "If that doesn't work, talk one of the Alliance engineers for help."

echo
info "Done! The current working directory is $PWD."
next_steps 
