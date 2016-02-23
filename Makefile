DOCKER_REGISTRY       = suma-docker-registry.suse.de
DOCKER_MOUNTPOINT     = /salt-tester
DOCKER_VOLUMES        = -v "$(CURDIR)/:$(DOCKER_MOUNTPOINT)"

all:	setup runtests teardown

setup:
	export OUTPUT_MODE="sparse"
	bash bin/teardown.sh
	bash bin/setup.sh

teardown:
	export OUTPUT_MODE="sparse"
	bash bin/teardown.sh

runtests:
	export OUTPUT_MODE="sparse"
	bash bin/tests.sh

jenkins: install setup runtests teardown

install:
	zypper --non-interactive in salt-master salt-minion
	zypper --non-interactive source-install salt
	zypper --non-interactive in --oldpackage test-package=42:0.0

docker_tests ::
	docker run --rm $(DOCKER_VOLUMES) $(DOCKER_REGISTRY)/suma-head-salt make -C $(DOCKER_MOUNTPOINT) jenkins

docker_shell ::
	docker run -t -i --rm $(DOCKER_VOLUMES) $(DOCKER_REGISTRY)/suma-head-salt /bin/bash
