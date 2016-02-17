all:	setup runtests teardown

setup:
	bash bin/teardown.sh
	bash bin/setup.sh

teardown:
	bash bin/teardown.sh

runtests:
	bash bin/tests.sh

jenkins:
        export OUTPUT_MODE="sparse"
        install setup runtests teardown

install:
	zypper --non-interactive in salt-master
	zypper --non-interactive in salt-minion
	zypper --non-interactive source-install salt
	zypper --non-interactive in --oldpackage test-package=42:0.0
