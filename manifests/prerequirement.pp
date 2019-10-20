class eyaml::prerequirement {
  exec {'eyaml createkeys':
    path    => ['/opt/puppetlabs/puppet/bin'],
    creates => '/etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem',
    require  => Class["eyaml::install"],
  }

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

  file { 'eyaml private key':
    path       => '/etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem',
    ensure     => present,
    owner      => 'puppet',
    mode => '0400',
  }

  file { 'eyaml public key':
    path       => '/etc/puppetlabs/puppet/eyaml/public_key.pkcs7.pem',
    ensure     => present,
    owner      => 'puppet',
    mode       => '0400',
  }
  
  file_line { 'export EYAML_CONFIG':
    path  => '/root/.bashrc',
    line  => 'export EYAML_CONFIG=/etc/puppetlabs/code/environments/production/config.yaml',
    match => "^export\ EYAML_CONFIG"
  }

File["eyaml config"] -> File_Line["export EYAML_CONFIG"]-> Exec["eyaml createkeys"] -> File["eyaml private key"] -> File["eyaml public key"] 
  
}
