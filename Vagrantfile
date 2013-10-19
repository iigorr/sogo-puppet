Vagrant::Config.run do |config|
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"


  config.vm.define "gw" do |gw|
    gw.vm.box = "gw"
    gw.vm.host_name = "gw.dev"

    gw.vm.network :hostonly, "192.168.23.23"
    gw.vm.forward_port 80, 80

    gw.vm.provision :puppet do  |puppet|
      puppet.manifests_path = "puppet/vagrant-manifests"
      puppet.manifest_file = "gw.pp"
      puppet.module_path  = "puppet/modules"
      puppet.facter = { "fqdn" => "gw.dev" }
    end

  end

end
