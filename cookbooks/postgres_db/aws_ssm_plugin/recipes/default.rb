remote_file '/tmp/session-manager-plugin.rpm' do
  source 'https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm'
  mode '0644'
end

rpm_package 'session-manager-plugin' do
  source '/tmp/session-manager-plugin.rpm'
  action :install
end

# Verify installation
execute 'check_ssm_plugin_installation' do
  command 'rpm -q session-manager-plugin'
  action :run
end
