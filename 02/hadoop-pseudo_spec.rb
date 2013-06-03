require 'spec_helper'

# package
%w(perl vim-enhanced
   hadoop-0.20-conf-pseudo
   hadoop-hdfs-namenode hadoop-hdfs-datanode hadoop-hdfs-secondarynamenode
   hadoop-0.20-mapreduce-jobtracker hadoop-0.20-mapreduce-tasktracker
  ).each do |pkg|

  describe package(pkg) do
    it { should be_installed }
  end

end

# service
%w(iptables ip6tables).each do |s|
  describe service(s) do
    it { should_not be_enabled }
    it { should_not be_running }
  end
end

# selinux
describe selinux do
  it { should be_disabled }
end

# service
%w(hadoop-hdfs-namenode hadoop-hdfs-datanode hadoop-hdfs-secondarynamenode
   hadoop-0.20-mapreduce-jobtracker hadoop-0.20-mapreduce-tasktracker
  ).each do |service|

  describe service(service) do
    it { should be_enabled }
    it { should be_running }
  end

end

# port
[8020, 8021, 50030, 50070].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

# file
describe file('/etc/hadoop/conf/core-site.xml') do
  it { should be_file }
  it { should contain "fs.default.name" }
end

describe file('/etc/hadoop/conf/mapred-site.xml') do
  it { should be_file }
  it { should contain "mapred.job.tracker" }
end
