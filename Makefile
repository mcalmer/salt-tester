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
	zypper --non-interactive in salt-master
	zypper --non-interactive in salt-minion
	zypper --non-interactive source-install salt
	zypper --non-interactive in --oldpackage test-package=42:0.0
