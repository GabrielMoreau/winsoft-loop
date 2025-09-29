# WinSoft-Loop - Windows AutoBuild Silent Package Software - Loop part

The architecture of a WinSoft installation is modular and consists of several independent folders.
All folders must be located under the same root directory, let's say `ws`.

* `winsoft-main`: main project folder containing the definitions of numerous public (or private) software packages.
  Public here does not mean free, but accessible.

* `winsoft-conf`: main project folder containing configurations for certain software (such as the time server, etc.).
  This folder is not public, and each site maintains its own version on its forge.

* `winsoft-close`: clone of `winsoft-main`, but containing software specific to your site.
  The definitions and names of the packages are not public.
  Each site has its own forge and there is no inter-site collaboration on these recipes.

* `winsoft-loop`: mini folder for launching actions on all `winsoft-*` repositories.
  We have mentioned `main` and `close`, but there is nothing to stop you from creating as many as you want.
  Only `close` and `loop` have specific names that exclude them from the execution loop.


Usage:

```bash
make help                # show this help
make all                 # clean old package and build all package
make build-all           # build all package
make clean-all           # clean all package
make last-checksum       # check for new checksum package
make unrealized-updates  # check for unrealized package
make list-pkg            # list all package
make list-version        # list all version
make list-md             # list all package in markdown format
make space               # clean old package
make version             # get all package version
make git-status          # git status
make git-pull            # git pull
make git-push            # git push update type file (checksum, url, version)
make git-push-all        # git push all files
make ocs-push            # push package on ocs server
```
