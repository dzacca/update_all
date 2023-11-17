# update_all

## A simple script to update my ubuntu-based systems

This is just a small and VERY simple script I prepared to keep my ubuntu-based
system up to date.

### Usage

Well, this is simple: you just run the script

### Configuration

The only configuration needed is on line 6 of the script to set it up to use
apt or any other apt-syntax-compatible tool (I use nala).

The default uses nala:

```shell
export APT=`which nala`
```

to use apt change it to:
```shell
export APT=`which apt`
```

### Assumptions

You are part of the sudoers group and, ideally, you configured your sudoers
file to allow you to sudo without password at least for the commands called in
the script.

### License
This script is released under MIT License.
