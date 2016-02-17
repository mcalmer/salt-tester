all:	setup runtests teardown

setup:
	bash bin/teardown.sh
	bash bin/setup.sh

teardown:
	bash bin/teardown.sh

runtests:
	bash bin/tests.sh

jenkins: install setup runtests teardown

install:
	zypper --non-interactive in salt-master
	zypper --non-interactive in salt-minion
	zypper --non-interactive in --oldpackage test-package=42:0.0
	# deps for unit tests
	zypper --non-interactive in python-mock python-pip python-salt-testing python-unittest2
