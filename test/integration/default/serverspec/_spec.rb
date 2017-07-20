require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/opt/mattermost/') do
  it { should be_directory }
  it { should be_owned_by 'mattermost' }
  it { should be_grouped_into 'mattermost' }
  it { should be_mode 755 }
end

describe file('/opt/mattermost/config/config.json') do
  it { should be_file }
  it { should be_owned_by 'mattermost' }
  it { should be_grouped_into 'mattermost' }
  it { should be_mode 644 }
  its(:content) { should match /"DataSource"\: "mmuser\:mmuser_password\@tcp\(localhost\:3306\)\/mattermost\?charset=utf8mb4,utf8",/ }
  its(:content) { should match /"Directory": "\/opt\/mattermost\/data",/ }
end

if host_inventory['virtualization'][:system] == "vbox"
  describe file('/usr/lib/systemd/system/mattermost.service') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end
else
  describe file('/etc/init.d/mattermost') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end
end
