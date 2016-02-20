Vagrant.configure('2') do |c|
  c.vm.box = 'centos6'
  c.vm.hostname = 'nginx.lan.ianduffy.ie'

  c.landrush.enabled = true
  c.landrush.tld = 'lan.ianduffy.ie'
  c.vm.network 'private_network', ip: '192.168.254.11'

  c.vm.provider :virtualbox do |p|
    p.customize ['modifyvm', :id, '--cpus', '1']
    p.customize ['modifyvm', :id, '--memory', '4096']
  end

  c.vm.provision 'chef_solo' do |chef|
    chef.install = false

    chef.run_list = %w(
      recipe[nginx::default]
    )
  end
end
