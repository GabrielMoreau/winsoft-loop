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
  If you do not like the name `winsoft-close`, you can choose `winsoft-local` or any name beginning with `winsoft-`.

* `winsoft-loop`: mini folder for launching actions on all `winsoft-*` repositories.
  We have mentioned `main` and `close`, but there is nothing to stop you from creating as many as you want.
  Only `close` and `loop` have specific names that exclude them from the execution loop.


Usage:

```bash
make help                # show this help
make all                 # clean old package and build all package
make build-all           # build all package
make clean-all           # clean all package
make last-checksum       # check for new checksum package (TIMEWINDOW var)
make unrealized-updates  # check for unrealized package
make list-pkg            # list all package
make list-version        # list all version
make list-md             # list all package in markdown format
make quality             # check code quality
make space               # clean old package (KEEP var)
make version             # get all package version
make git-status          # git status
make git-pull            # git pull
make git-push            # git push update type file (checksum, url, version)
make git-push-all        # git push all files (.no-ocs-pkgpush file)
make ocs-push            # push last package on ocs server (TIMEWINDOW var, LOOP var, .no-ocs-pkgpush file)
make ocs-push-all        # push all package on ocs server
```

Variables and files specific to certain targets:

* `TIMEWINDOW`: Searches only packets newer than this date (duration).
  By default, it is set to 1.25, which is one day and a quarter, meaning it applies to all packets less than 30 hours old.
  It must be configured in each `Makefile` of the `winsoft-*` project.

* `LOOP`: Sometimes, it may be useful to loop through all packages multiple times.
  For example, with a weak Wi-Fi + VPN connection, uploading certain packages to the OCS server may fail.
  With the LOOP variable set to 2 or 3, there will be 2 or 3 upload attempts.
  Note that all packages are uploaded before retrying.
  By default, it is set to 1.
  This variable is configured in the single `Makefile` of the `winsoft-loop` project.
  It is modified via the command line when the target is invoked.

* `.no-ocs-pkgpush`: This file prevents the package from being uploaded to an OCS server.
  It is an empty file that must be placed in every folder where a package is not used on the organization's computer network.
  This prevents your OCS server from becoming cluttered with unnecessary packages.
