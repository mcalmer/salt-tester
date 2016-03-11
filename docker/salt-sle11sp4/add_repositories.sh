#!/bin/bash
set -e

zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11:/GA/standard "SLE11 GA"
zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11:/Update/standard/ "SLE11 Updates"
zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11-SP1:/GA/standard "SLE11 SP1 GA"
zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11-SP1:/Update/standard "SLE11 SP1 Updates"
zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11-SP2:/GA/standard "SLE11 SP2 GA"
zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11-SP2:/Update/standard "SLE11 SP2 Updates"
zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11-SP3:/GA/standard "SLE11 SP3 GA"
zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11-SP3:/Update/standard "SLE11 SP3 Updates"
zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11-SP4:/GA/standard "SLE11 SP4 GA"
zypper ar -f http://download.suse.de/ibs/SUSE:/SLE-11-SP4:/Update/standard "SLE11 SP4 Updates"

zypper ar -f http://download.opensuse.org/repositories/systemsmanagement:/saltstack/SLE_11_SP4/ "salt"
zypper ar -f http://download.opensuse.org/repositories/systemsmanagement:/saltstack:/testing/SLE_11_SP4/ "salt_testing"
zypper ar -f http://download.opensuse.org/repositories/systemsmanagement:/saltstack:/testing:/testpackages/SLE_11_SP4/ "salt_testing_pkg"

