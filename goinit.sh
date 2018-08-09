#!/bin/bash
options=("1.8" "1.9.1" "1.9.2" "1.9.3" "1.9.4" "1.9.5" "1.9.6" "1.9.7" "1.10.1" "1.10.2" "1.10.3")

#allow user to select whichever ver they wish
echo "Select one of the golang's version from below.."
echo "ex- 1 for 1.8"
select download_version in "${options[@]}"
do
    echo "$download_version selected"
    break
done

#getting the arch
if [[ "$OSTYPE" = *"darwin"* ]]; then
  arch="darwin"
  download_file="go$download_version.darwin-amd64.tar.gz"
elif $(uname -m | grep '64'); then
  arch="64"
  download_file="go$download_version.linux-amd64.tar.gz"
else
  arch="32"
  download_file="go$download_version.linux-386.tar.gz"
fi

#getting which shell script running
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    # assume Zsh
    shell_profile="zshrc"
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    # assume Bash
    shell_profile="bashrc"
fi

#in mac systems sed requires extra '' 
if [ "$arch" = "darwin" ]; then
    rm -rf "$HOME/.go/"
    rm -rf "$HOME/goworkspace/"
    sed -i '' '/# GoLangConfig/d' "$HOME/.${shell_profile}"
    sed -i '' '/export GOROOT/d' "$HOME/.${shell_profile}"
    sed -i '' '/:$GOROOT/d' "$HOME/.${shell_profile}"
    sed -i '' '/export GOPATH/d' "$HOME/.${shell_profile}"
    sed -i '' '/:$GOPATH/d' "$HOME/.${shell_profile}"
    echo "Go removed."
else
    rm -rf "$HOME/.go/"
    rm -rf "$HOME/goworkspace/"
    sed -i '/# GoLangConfig/d' "$HOME/.${shell_profile}"
    sed -i '/export GOROOT/d' "$HOME/.${shell_profile}"
    sed -i '/:$GOROOT/d' "$HOME/.${shell_profile}"
    sed -i '/export GOPATH/d' "$HOME/.${shell_profile}"
    sed -i '/:$GOPATH/d' "$HOME/.${shell_profile}"
    echo "Go removed."
fi

#checking if install dirs aren't pre-occupied
if [ -d "$HOME/.go" ] || [ -d "$HOME/goworkspace" ]; then
    echo "The 'goworkspace' or '.go' directories already exist. Exiting."
    exit 1
fi

if [[ ! -e $HOME/goworkspace ]]; then
    mkdir $HOME/goworkspace
elif [[ ! -d $dir ]]; then
    echo "$HOME/goworkspace already exists but is not a directory" 1>&2
fi

if [[ ! -e $HOME/.go ]]; then
    mkdir $HOME/.go
elif [[ ! -d $dir ]]; then
    echo "$HOME/.go already exists but is not a directory" 1>&2
fi

echo "Downloading $download_file ...."
wget https://storage.googleapis.com/golang/$download_file -O /tmp/go.tar.gz 2>/dev/null || curl https://storage.googleapis.com/golang/$download_file --output /tmp/go.tar.gz

if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi


echo "Extracting File..."
tar -C "$HOME" -xzf /tmp/go.tar.gz
mv "$HOME/goworkspace" "$HOME/.go"
touch "$HOME/.${shell_profile}"

echo "Setting GOPATH GOROOT......"
{
    echo '# GoLangConfig '
    echo 'export GOROOT=$HOME/.go'
    echo 'export PATH=$PATH:$GOROOT/bin'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin'
} >> "$HOME/.${shell_profile}"

echo "Making src, pkg and bin inside goworkspace"
mkdir -p $HOME/goworkspace/{src,pkg,bin}
echo -e "\nGo $download_version was installed"
echo -e "\n\tsource $HOME/.${shell_profile}\n\nto update your environment variables."
echo "Run source ~/.${shell_profile} or open a new terminal window to test it."
rm -f /tmp/go.tar.gz