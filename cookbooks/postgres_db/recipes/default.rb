package 'postgresql-server' do
  action :install
end

package 'postgresql-contrib' do
  action :install
end

execute 'initialize-postgres' do
  command 'postgresql-setup initdb'
  not_if { File.exist?('/var/lib/pgsql/data/PG_VERSION') }
end

service 'postgresql' do
  action [:enable, :start]
end
