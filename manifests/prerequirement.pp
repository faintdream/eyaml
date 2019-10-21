#This class configures pre steps for using eyaml in our setup
class eyaml::prerequirement {

  file { 'eyaml config':
    path       => '/etc/puppetlabs/code/environments/production/config.yaml',
    ensure     => file,
    content    => @("EOF"),
                  ---
                  pkcs7_private_key: /etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem
                  pkcs7_public_key: /etc/puppetlabs/puppet/eyaml/public_key.pkcs7.pem
                  |EOF
    owner      => 'puppet',
    mode       => '0700',
  }
  
  file_line { 'export EYAML_CONFIG':
    path  => '/root/.bash_profile',
    line  => 'export EYAML_CONFIG=/etc/puppetlabs/code/environments/production/config.yaml',
    match => "^export EYAML_CONFIG"
  }

File["eyaml config"] -> File_Line["export EYAML_CONFIG"] 
  
}
