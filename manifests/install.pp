class eyaml::install(
  String $package ){
  package{ $package:
    ensure   => installed,
    provider => gem,
  }
}
