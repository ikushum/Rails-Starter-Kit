#!/usr/bin/env bash
set -e
set -o noclobber
RED='\033[0;36' 

if
  [[ "${USER:-}" == "root" ]]
then
  echo "Please log in as normal user and try again." >&2
  exit 1
fi
 
if [[ $1 == 'rails' ]]
	then

	sudo echo

	read -p "Install Ruby ?* (y/n) : " rb
	if [[ $rb == 'Y' || $rb == 'y' || $rb == '' ]]
	then
		rb=true
		echo -e '\e[36mRuby will be installed\e[0m' >&2
	else
		rb=false
		echo -e '\e[36mRuby will not be installed\e[0m'
	fi

	read -p "Install Node.js ?* (y/n) : " njs
	if [[ $njs == 'Y' || $njs == 'y' || $njs == '' ]]
	then
		njs=true
		echo -e '\e[36mNode.js will be installed\e[0m' >&2
	else
		njs=false
		echo -e '\e[36mNode.js will not be installed\e[0m'
	fi	

	read -p "Install Postgres ? (y/n) : " pg
	if [[ $pg == 'Y' || $pg == 'y' || $pg == '' ]]
	then
		echo -e '\e[36mPostgres will be installed\e[0m'
		pg=true
	else
		pg=false
		echo -e '\e[36mPostgres will not be installed\e[0m'
	fi

	read -p "Install Git ? (y/n) : " gt
	if [[ $gt == 'Y' || $gt == 'y' || $gt == '' ]]
	then
		echo -e '\e[36mGit will be installed\e[0m'
		gt=true
	else
		gt=false
		echo -e '\e[36mGit will not be installed\e[0m'
	fi	

	read -p "Install Heroku CLI ? (y/n) : " heroku
	if [[ $heroku == 'Y' || $heroku == 'y' || $heroku == '' ]]
	then
		echo -e '\e[36mHeroku CLI will be installed\e[0m'
		heroku=true
	else
		heroku=false
		echo -e '\e[36mHeroku CLI will not be installed\e[0m'
	fi		

	echo 
	echo -e '\e[36mPreparing to Install...\e[0m'
	echo
	echo -e '\e[36mUpdating your packages\e[0m'
	sudo apt-get update -y
	sudo apt-get --ignore-missing install build-essential patch ruby-dev zlib1g-dev liblzma-dev -y
	echo -e '\e[36mInstalling Curl\e[0m'
	sudo apt-get install curl -y

	if $rb
	then
		echo -e '\e[36mInstalling RVM (Ruby Version Manager)\e[0m'
		gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
		curl -sSL https://get.rvm.io | bash -s stable
		source ~/.rvm/scripts/rvm

		echo "Installing Ruby"
		rvm install 2.4.2
		rvm use 2.4.2 --default
		gem install bundler
	fi

	if $njs
	then
		echo -e '\e[36mInstalling Node.js\e[0m'
		curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
		sudo apt-get install nodejs -y
	fi	

	if true
	then
		echo -e '\e[36mInstalling Rails...\e[0m'
		gem install nokogiri
		gem install rails
	fi	

	if $pg
	then
		echo -e '\e[36mInstalling Postgres...\e[0m'
		sudo apt-get install postgresql postgresql-contrib libpq-dev pgadmin3 -y
	fi

	if $gt
	then
		echo -e '\e[36mInstalling Git...\e[0m'
		apt-get install git
	fi	

	if $heroku
	then
		echo -e '\e[36mInstalling Heroku CLI...\e[0m'
		wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
	fi

elif [[ $1 == '' ]]
then
	echo 'Please run '\''rsk rails'\'' to install rails'
else
	echo "$1 is not recognised"
fi
