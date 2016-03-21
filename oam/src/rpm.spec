Summary: highly available clustering for web servers 
Name: eddie
#
########################################
# Uncomment "% define" and "Requires"
# for your intended RedHat version
#
##### Need to be substituted. #####
#%define rhrel %REDHATRELEASE%
#Requires: redhat-release < 6.0
#Requires: redhat-release >= 6.0
#
%define rel 1
Version: 1.5.0
Release: %{rel}
Copyright: Ericsson Commercial
Group: Networking/Daemons
Source0: eddie-%{version}.tar.gz
Provides: eddie
BuildRoot: /var/tmp/eddie-root
URL: http://www.eddieware.org/
Packager: geoff@eddieware.org


%description
Eddie is a highly available clustering solution for web servers.
It allows arbitrary scaling of a single virtual web site.
Load balancing is supported at two levels. Load balancing
is done at the cluster level with the Load Balancing DNS,
and within the cluster by the Intelligent HTTP gateway.
IP migration is used to implement a failover mechanism. 
Admission control allows web sites to control the load on 
their machines and provide a guaranteed level of service
from the backends.

%prep

%setup


%build
OPTIM="$RPM_OPT_FLAGS" ./configure \
	--prefix=/usr/local \
	--sysconfdir=/etc/eddie \
	--with-logdir=/var/eddie \

make


%install
rm -rf $RPM_BUILD_ROOT
make install root="$RPM_BUILD_ROOT"

# docs workaround
mkdir -p $RPM_BUILD_ROOT/usr/doc/eddie-%{version}
cp -r $RPM_BUILD_ROOT/usr/local/share/eddie/* $RPM_BUILD_ROOT/usr/doc/eddie-%{version}
#rm -rf $RPM_BUILD_ROOT/usr/local/lib/eddie/doc/

# sysv init
mkdir -p $RPM_BUILD_ROOT/etc/rc.d/init.d
install oam/priv/lbdns.init $RPM_BUILD_ROOT/etc/rc.d/init.d/lbdns
install oam/priv/eddie.init $RPM_BUILD_ROOT/etc/rc.d/init.d/eddie


%pre


%post


%clean
rm -rf "$RPM_BUILD_ROOT"


%files
%attr( - ,root,daemon)  %dir /etc/eddie
%attr( - ,root,-)  %config(noreplace) /etc/eddie/eddie.conf
%attr( - ,root,-)  %config(noreplace) /etc/eddie/eddie.gate
%attr( - ,root,-)  %config(noreplace) /etc/eddie/eddie.mig
%attr( - ,root,-)  %config(noreplace) /etc/eddie/lb_dns.boot
%attr( - ,root,-)  %config(noreplace) /etc/eddie/tpl_queue.html
%attr( - ,root,-)  %config(noreplace) /etc/eddie/tpl_blocked.html
%attr( - ,root,-)  %config(noreplace) /etc/eddie/tpl_reject.html

%attr( - ,root,-)  /etc/eddie/*.dist
%attr( - ,root,-)  /etc/rc.d/init.d/*

%attr( - ,root,-)  /usr/local/sbin/*
%attr( - ,root,-)  /usr/local/lib/eddie
%attr( - ,root,-)  %dir /var/eddie

%attr( - ,root,root)  %doc /usr/doc/eddie-%{version}


%changelog
* Tue Sep 23 1999 Magnus Stenman <stone@hkust.se>
- revamped spec file
