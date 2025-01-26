package 'amazon-cloudwatch-agent' do
  action :install
end

service 'amazon-cloudwatch-agent' do
  action [:enable, :start]
end