TAG=foobar

include ~/secrets/rhn_subscription.env

setup:
    echo ${RHN_USERNAME}

foo: setup
    echo I made secret

make-secret:
    echo "mysecretcontents" > file_containing_secrets.txt

build-without-buildkit : make-secret
    docker build --no-cache -f Dockerfile -t ${TAG} .

build-with-buildkit : make-secret
    DOCKER_BUILDKIT=1  docker build -f Dockerfile-vmlet-rhel8 -t vmlet-rhel8-secret  --secret id=creds,src=rhn_subscription.env --build-arg=RHEL_VERSION=8.3    .

		
		
		docker build --no-cache --secret id=mycoolsecret,src=file_containing_secrets.txt --progress=plain -f Dockerfile-buildkit -t ${TAG}-buildkit .
