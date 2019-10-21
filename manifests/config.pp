#This class deploy the pgp key files for eyaml action
class eyaml::config {

  file { 'eyaml private key':
    path   => '/etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem',
    ensure => present,
    owner  => 'puppet',
    mode   => '0400',
    source => 'puppet:///modules/eyaml/private_key.pkcs7.pem',
  }

  file { 'eyaml public key':
    path       => '/etc/puppetlabs/puppet/eyaml/public_key.pkcs7.pem',
    ensure     => present,
    owner      => 'puppet',
    mode       => '0400',
    source => 'puppet:///modules/eyaml/public_key.pkcs7.pem'
  }
}
