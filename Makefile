__docker_build=docker build --platform linux/amd64
ifeq ($(shell uname -m),arm64)
## NOTE: We use buildx plugin, which is an experimental plugin.
__docker_build=docker buildx build --load --platform linux/amd64
endif

all:

.PHONY: local/vineseed
local/vineseed:
	${__docker_build} -t local/vineseed  ./vineseed/

vineseed/VineSeed_x86_64-docker-snapshot.tar.xz:
	cd vineseed && ./_make-base-tarball.sh

.PHONY: local/vbuilder
local/vbuilder:
	${__docker_build} -t local/vbuilder  ./vbuilder/

.PHONY: clean
clean:
	find  . -name "*~" | xargs rm -f

# end of file
