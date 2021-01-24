VERSION=8.3

build:
	DOCKER_BUILDKIT=1 \
		docker build \
		-f Dockerfile-vmlet-rhel-8 \
		-t vmlet-rhel8 \
		--secret id=rhn,src=/Users/tok/secrets/rhn_subscription.sh \
		--build-arg=RHEL_VERSION=${VERSION} \
		--squash .

build-epel:
	DOCKER_BUILDKIT=1 \
		docker build \
		-f Dockerfile-vmlet-rhel-8-epel \
		-t vmlet-rhel8-epel \
		--build-arg=RHEL_VERSION=${VERSION} \
		--squash .
