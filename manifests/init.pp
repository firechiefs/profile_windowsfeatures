# PURPOSE:
# Installs windowsfeatures in hiera via create_resources stlib function
#
# HIERA DATA:
# profile::windowsfeatures:
# Should be dsc_windowsfeature resource hash as documented here:
# https://forge.puppetlabs.com/puppetlabs/dsc#adding-or-removing-windows-features
# Determining valid Feature Names:
# --> windows: Get-WindowsFeature | select Name
#
# HIERA EXAMPLE:
# profile::windowsfeatures:
#   Web-Server:
#     dsc_name: 'Web-Server'
#     dsc_ensure: 'present'
#     dsc_includeallsubfeature: true
#
# MODULE DEPENDENCIES:
# puppet module install puppetlabs-dsc

class profile_windowsfeatures {
  # HIERA LOOKUP:
  # --> PUPPET CODE VARIABLES:
  # merge all Feature data into one hash
  # hiera_hash merges keys from all yaml sources
  # http://docs.puppetlabs.com/puppet/latest/reference/function.html#hierahash
  $windowsfeatures = hiera_hash('profile::windowsfeatures',false)

    # PUPPET CODE:
    if ($windowsfeatures) {

      # HIERA LOOKUP VALIDATION:
      validate_hash($windowsfeatures)
      # create dsc_windowsfeature resources
      # --> create_resources doc:
      #  http://docs.puppetlabs.com/puppet/latest/reference/function.html#createresources
      create_resources(dsc_windowsfeature, $windowsfeatures)

      # VALIDATION CODE:
      # --> MODIFY VARIABLES BELOW:
      $profile_name    = 'profile_windowsfeatures'   # set to profile name
      $validation_data = $windowsfeatures            # windowsfeature names

      # Puppet custom define type
      # documented in: site/validation_script/manifests/init.pp
      # DO NOT MODIFY BELOW !!!
        validation_script { $profile_name:
          profile_name    => $profile_name,
          validation_data => $validation_data,
    }
  }
}
