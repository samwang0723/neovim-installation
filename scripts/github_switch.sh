#!/bin/sh

# Make sure have all these installed
# group :development do
# A Ruby language server and suite of static analysis tools. Used in VSCode (https://solargraph.org)
# Manually set solargraph.bundlerPath to the shim path of solargraph
#  gem 'solargraph'
#  gem 'solargraph-rails'
#  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git'
#
# .rubocop.yml
#  require:
#  - rubocop-rspec
#  - rubocop-rails

# Store the current working directory in a variable
current_dir=$(pwd)

# Configure the git commit to local repo
configure_repo() {
	git config --local commit.gpgSign true
	git config --local user.email "xxxx@gmail.com"
	git config --local user.name "xxxxx"
	git config --local user.signingkey XXXXXXXX
}

# Execute the database migration command
database_migration() {
	echo "Running database migrations"

	# Check if the current working directory contains "monaco-rails"
	if echo "$current_dir" | grep -q "monaco-rails"; then
		./bin/setup_db
	# Check if the current working directory contains "crypto-fiat"
	elif echo "$current_dir" | grep -q "crypto-fiat"; then
		docker-compose down --volumes
		sleep 10
		docker-compose up -d -V db-fiat
		sleep 10
		bin/rails db:create db:migrate db:seed
	else
		echo "Error: The current working directory does not contain either 'monaco-rails' or 'crypto-fiat'"
		exit 1
	fi
}

# Function to replace the strings
replace_strings() {
	sed -i '' 's/git@github.com:monacohq/git@work:monacohq/g' Gemfile

	# check if file exists
	if [ -f Gemfile ]; then
		# check if the line exists in the file
		if grep -q "gem 'annotate'" Gemfile; then
			# delete the line containing "gem 'annotate'"
			sed -i '' "/gem 'annotate'/d" Gemfile
			echo "Line deleted successfully from Gemfile"
		else
			echo "Line not found in Gemfile"
		fi
	else
		echo "Gemfile not found"
	fi

	# backup the original Gemfile
	cp Gemfile Gemfile.bak

	# create a new Gemfile with the desired content
	awk '/group :development do/{print;print "  gem '\''solargraph-rails'\''";print "  gem '\''annotate'\'', git: '\''https://github.com/ctran/annotate_models.git'\''";next}1' Gemfile.bak >Gemfile
}

generate_annotate() {
	rails g annotate:install
	rake annotate_models
	rake annotate_routes
}

# Function to reset the changes
reset() {
	git checkout Gemfile
	git checkout Gemfile.lock
	git stash
	rm lib/tasks/auto_annotate_models.rake
	rm Gemfile.bak
	echo "Changes reset successfully"
}

# Usage message
usage() {
	echo "Usage: $0 [-h|--help] [revert|reset|replace|bundle|migrate|configure]"
	echo "  -h, --help     Show this help message and exit"
	echo "  reset          Reset the changes made by Git"
	echo "  replace        Replace the @github.com:monacohq to @work:monacohq in the file"
	echo "  bundle         Execute the replace and run bundle install"
	echo "  migrate        Run database migrations based on folder location"
	echo "  configure      Configure the git commit to local repo"
	echo "  annotate       Generate the annotate models"
}

# Check if the first argument is -h or --help
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
	usage
	exit 0
fi

# Input file location
file=Gemfile

# Check if the file exists
if [ ! -f $file ]; then
	echo "Error: The file $file does not exist"
	exit 1
fi

# Check if the second argument is provided
if [ $# -eq 1 ]; then
	if [ "$1" == "reset" ]; then
		reset
		echo "Gemfile reset to HEAD successfully"
	elif [ "$1" == "replace" ]; then
		replace_strings $file
		echo "Changes replaced successfully"
	elif [ "$1" == "bundle" ]; then
		replace_strings $file
		echo "Changes replaced successfully, running bundle install"
		bundle install
	elif [ "$1" == "migrate" ]; then
		database_migration
	elif [ "$1" == "configure" ]; then
		configure_repo
	elif [ "$1" == "annotate" ]; then
		generate_annotate
	else
		echo "Error: Invalid argument"
		exit 1
	fi
fi
