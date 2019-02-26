<h1 align="center">
    <br>
    <img width="400" src="https://github.com/solodynamo/go-init/blob/master/media/logo.png" alt="go-init">
    <br>
    <br>
    <br>
</h1>

> The simple no fuss solution to your Go ambitions.

**go-init**:
- Provides option to select the version of go to be downloaded.
- Downloads appropriate go binary of your selected version for your platform from official google source.
- Extracts the binary and runs it,
- Setups $GOROOT and $GOPATH by entering required path variables into your zsh or bash shell automatically.
- Removes the downloaded .gz file and cleans things up.
- Remove past installations using the script.

It is written with an aim to fasten golang setup. 

## Table of Contents
- [Install](#install)
- [Usage](#usage)
- [Example](#example)
- [Where it sets $GOROOT and $GOPATH ?](#info)
## Install

```sh
# wget or curl the script
$ wget https://raw.githubusercontent.com/solodynamo/go-init/master/goinit.sh
$ curl https://raw.githubusercontent.com/solodynamo/go-init/master/goinit.sh > goinit.sh

# Alternatively you can clone the repo and use it.
$ git clone git@github.com:solodynamo/go-init.git

```

## Usage
- install go
```html
./goinit.sh
```
- removes go
```html
./goinit.sh -goaway
```
## Example
<h3 align="center">
    <br>
    <img width="400" src="https://github.com/solodynamo/go-init/blob/master/media/snap.png" alt="go-init-snap">
    <br>
    <br>
    <br>
</h3>

## Info
Path set for $GOROOT and $GOPATH 
```html
export GOROOT=$HOME/.go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/goworkspace
export PATH=$PATH:$GOPATH/bin
```

## Contribute

Always do :)

## License

[MIT](LICENSE) © [Solodynamo](https://solodynamo.github.io/)
