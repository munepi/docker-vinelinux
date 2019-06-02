all:

local/vineseed:
	docker build -t local/vineseed  ./vineseed/

vineseed/VineSeed_x86_64-docker-snapshot.tar.xz:
	cd vineseed && ./_make-base-tarball.sh

local/vbuilder:
	docker build -t local/vbuilder  ./vbuilder/

clean:
	find  . -name "*~" | xargs rm -f

# end of file
