## PURPOSE:

Installs windowsfeatures in hiera via create_resources stlib function

## HIERA DATA:

profile::windowsfeatures:

Should be dsc_windowsfeature hash of resource hashes as documented here:
https://forge.puppetlabs.com/puppetlabs/dsc#adding-or-removing-windows-features

Determining valid Feature Names:

  windows:
  ```Get-WindowsFeature | select Name```

## HIERA EXAMPLE:
```
  profile::windowsfeatures:
    Web-Server:
      dsc_name: 'Web-Server'
      dsc_ensure: 'present'
      dsc_includeallsubfeature: true
    Telnet-Client:
      desc_name: 'Telnet-Client'
      dsc_ensure: 'present'

```

## MODULE DEPENDENCIES:
```
puppet module install puppetlabs-dsc
```
## USAGE:

#### Puppetfile:
```
mod 'puppetlabs-dsc',
  :git => 'https://github.com/puppetlabs/puppetlabs-dsc',
  :tag => '1.0.0'

mod 'validation_script',
  :git => 'https://github.com/firechiefs/validation_script',
  :ref => '1.0.0'

mod 'profile_dotnet',
  :git => 'https://github.com/firechiefs/profile_windowsfeatures',
  :ref => '1.0.0'
```
#### Manifests:
```
class role::*rolename* {
  include profile_windowsfeatures
}
```
