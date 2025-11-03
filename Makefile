PKGDIR:=$(filter-out ../winsoft-conf ../winsoft-loop, $(wildcard ../winsoft-*))

.PHONY: help all build-all clean-all last-checksum unrealized-updates list-pkg list-version list-md space version git-status git-pull git-push git-push-all ocs-push ocs-push-all
.ONESHELL:

help: ## show this help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n"} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36mmake %-19s\033[0m #%s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

all: space build-all ## clean old package and build all package

build-all: ## build all package
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; make --quiet $@) \
	done

clean-all: ## clean all package
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; make --quiet $@) \
	done

last-checksum: ## check for new checksum package
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; make --quiet $@) \
	done

unrealized-updates: ## check for unrealized package
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; make --quiet $@) \
	done

list-pkg: ## list all package
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; make --quiet $@) \
	done

list-version: ## list all version
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; make --quiet $@) \
	done

list-md: ## list all package in markdown format
	@head --quiet --line 1 ../*/[a-z]*/README.md | egrep -v -i '(Uninstall|Dell SupportAssist|GlobalProtect|OpenJDK8JRE)' | sed -e 's/^#/ 1./;' | sort | \
		perl -pe 's/(AcrobatReader|AnyConnect|AnyDesk|BleachBit|BlueKenue|CitrixWorkspace|CloudCompare|GitForWindows|FastStone|HandBrake|KiCad|LightBulb|MathWorks|DjVu|OnlyOffice|OpenDocument|OpenShot|RocketChat|SimpleTruss|TeamViewer|TexMaker|TeXnicCenter|UltiMaker|VeraCrypt|VisualRedist|WithSecure|WinDirStat|WinMerge)/!$${1}/g;'

space: ## clean old package
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; grep -q "$@:" Makefile && make --quiet $@) \
	done

version: ## get all package version
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; make --quiet $@) \
	done

git-status: ## git status
	@for d in ./ $(PKGDIR) ; \
	do \
		(cd $$d; git status) \
	done

git-pull: ## git pull
	@for d in ./ $(PKGDIR) ; \
	do \
		(cd $$d; git pull) \
	done

git-push: ## git push update type file (checksum, url, version)
	@for d in ./ $(PKGDIR)
	do
		(
			cd $$d
			for soft in $$(git status --porcelain | grep '^[[:space:]]*[AM][[:space:]]' | awk '{print $$2}' | grep -E '/(checksum|version|url).txt$$' | xargs -r dirname | sort -u)
			do
				git add $$(git status --porcelain | grep '^[[:space:]]*[AM][[:space:]]' | awk '{print $$2}' | grep -E '/(checksum|version|url).txt$$' | grep "^$$soft/")
				git commit
			done
			git push
		)
	done

git-push-all: ## git push all files
	@for d in ./ $(PKGDIR) ; \
	do \
		(cd $$d; git commit -a; git push) \
	done

ocs-push: ## push last package on ocs server
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; make --quiet $@) \
	done

ocs-push-all: ## push all package on ocs server
	@for d in $(PKGDIR) ; \
	do \
		(cd $$d; make --quiet $@) \
	done
