require "yaml"

Vagrant::Config.run do |config|
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  yml = YAML.load_file "private/user.yml"

  username = 'vagrant'
  password = '$6$aqzOtgCM$OxgoMP4JoqMJ1U1F3MZPo2iBefDRnRCXSfgIM36E5cfMNcE7GcNtH1P/tTC2QY3sX3BxxJ7r/9ciScIVTa55l0'
  public_key= ''

  if yml.has_key?('username')
    username = yml['username']
  end

  if yml.has_key?('password')
    password = yml['password']
  end

  if yml.has_key?('public_key')
    public_key = yml['public_key']
  end


  config.vm.define "gw" do |gw|
    gw.vm.box = "gw"
    gw.vm.host_name = "gw.dev"

    gw.vm.network :hostonly, "192.168.23.23"
    gw.vm.forward_port 80, 80

    gw.vm.provision :puppet do  |puppet|
      puppet.manifests_path = "puppet/vagrant-manifests"
      puppet.manifest_file = "gw.pp"
      puppet.module_path  = "puppet/modules"
      puppet.facter = { 
        "fqdn" => "box.dev",
        'username' => username,
        'password' => password,
        'public_key' => public_key
      }
    end

  end

end
