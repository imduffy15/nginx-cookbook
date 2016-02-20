name             'nginx'
maintainer       'Ian Duffy'
maintainer_email 'ian@ianduffy.ie'
license          'apache2'
description      'Installs/Configures nginx'
long_description 'Installs/Configures nginx'
version          '0.0.1'

%w(amazon centos fedora oracle redhat scientific).each do |os|
  supports os
end

source_url 'https://github.com/imduffy15/nginx-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/imduffy15/nginx-cookbook/issues' if respond_to?(:issues_url)

depends 'yum', '3.10.0'
depends 'selinux_policy', '0.9.2'
