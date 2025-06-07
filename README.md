## Quick Start
A shell script is prepared to quickly deploy the configuration files.

```sh
git clone --recursive https://github.com/shimies/dotfiles.git
./dotfiles/linker.sh
```
`linker.sh` creates a symbolic link to each configuration file or directory in `$HOME`.
Thus, running those commands makes the configuration ready-to-use.
It, however, does not overwrite existing configuration files of yours.
The existing file is renamed by removing the prefix `.` from and adding the suffix `.bak` to its original name before the script actually creates a link.


## Partial Installation
To prevent all the configuration files from being linked, simply add a if-then-continue statement after the following in `linker.sh`.
If the filename denoted by `$filename` matches a pattern or a predicate on the filename holds, `continue` lets the flow move forward to the next iteration, skipping the linking.
```sh
# prevent files from being linked according to conditions
### if a filename simply matches a pattern
[ "$filename" = "README.md" ] && continue
[ "$filename" = "vrapperrc" ] && continue
### despite X config files, if no X server is running
[ -z "${filename%%X*}" ] && [ -z "$DISPLAY" ] && continue
```
