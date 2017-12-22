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
 	
sudo echo
echo -e '\e[93mWe strictly recommended you to install the underlined softwares. Only skip the installition if you have it pre installed on your system. \e[0m'
echo

echo -e "Install \e[4mRuby\e[0m ? (\e[92my/\e[91mn\e[0m) : \c"
read rb
if [[ $rb == 'Y' || $rb == 'y' || $rb == '' ]]
then
	rb=true
	echo -e '\e[36mRuby will be installed\e[0m' 
	echo
else
	rb=false
	echo -e '\e[36mRuby will not be installed\e[0m'
	echo
fi

echo -e "Install \e[4mNode.js\e[0m ? (\e[92my/\e[91mn\e[0m) : \c"
read njs
if [[ $njs == 'Y' || $njs == 'y' || $njs == '' ]]
then
	njs=true
	echo -e '\e[36mNode.js will be installed\e[0m'
	echo
else
	njs=false
	echo -e '\e[36mNode.js will not be installed\e[0m'
	echo
fi	

echo -e "Install Postgresql ? (\e[92my/\e[91mn\e[0m) : \c"
read pg
if [[ $pg == 'Y' || $pg == 'y' || $pg == '' ]]
then
	echo -e '\e[36mPostgresql will be installed\e[0m'
	echo
	pg=true
else
	pg=false
	echo -e '\e[36mPostgresql will not be installed\e[0m'
	echo
fi

echo -e "Install Git ? (\e[92my/\e[91mn\e[0m) : \c"
read gt
if [[ $gt == 'Y' || $gt == 'y' || $gt == '' ]]
then
	echo -e '\e[36mGit will be installed\e[0m'
	gt=true
	echo	
else
	gt=false
	echo -e '\e[36mGit will not be installed\e[0m'
	echo	
fi	

echo -e "Install Heroku CLI ? (\e[92my/\e[91mn\e[0m) : \c"
read heroku	
if [[ $heroku == 'Y' || $heroku == 'y' || $heroku == '' ]]
then
	echo -e '\e[36mHeroku CLI will be installed\e[0m'
	heroku=true
	echo	
else
	heroku=false
	echo -e '\e[36mHeroku CLI will not be installed\e[0m'
	echo	
fi	

echo -e "Install Sublime Text 3 ? (\e[92my/\e[91mn\e[0m) : \c"
read subl 
if [[ $subl == 'Y' || $subl == 'y' || $subl == '' ]]
then
	echo -e '\e[36mSublime Text 3 will be installed\e[0m'
	subl=true
	echo	
else
	subl=false
	echo -e '\e[36mSublime Text 3 will not be installed\e[0m'
	echo	
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
	echo -e '\e[36mInstalling Postgresql...\e[0m'
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

if $subl
then
	echo -e '\e[36mInstalling Sublime Text 3...\e[0m'
	sudo add-apt-repository ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install sublime-text-installer	
fi	

echo
echo -e '\e[92mInstalled Packages\e[0m'

if $rb
then
	ruby -v
fi

if true
then
	rails -v
fi		

if $njs
then
	echo -e "Node.js \c"
	node -v
fi	

if $pg
then
	psql --version
fi

if $gt
then
	git --version
fi	

if $heroku
then
	heroku -v
fi

if $subl
then
	subl -v
fi		

echo
echo -e '\e[92mCongratulation! Now you are all set to start doing Rails.\e[0m'
