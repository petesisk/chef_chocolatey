resource_name :manage_chocolatey_packages
provides :manage_chocolatey_packages, :os => 'windows'
default_action :manage

action :manage do
  return unless platform_family?('windows')

  return_codes = node['chocolatey_packages']['return_codes']

  unless node['chocolatey_packages']['installs'].empty?

    node['chocolatey_packages']['installs'].uniq.each do |name|
      chocolatey_package name do
        action :install
        returns return_codes
      end
    end
  end

  unless node['chocolatey_packages']['updates'].empty?

    node['chocolatey_packages']['updates'].uniq.each do |name|
      chocolatey_package name do
        action :upgrade
        returns return_codes
      end
    end
  end
end