all:	setup runtests teardown

setup:
	bash bin/teardown.sh
	bash bin/setup.sh

teardown:
	bash bin/teardown.sh

runtests:
	bash bin/tests.sh
