#
# Cookbook Name:: hadoop-pseudo
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# パッケージのインストール
%w(perl vim).each do |p|
  package p do
    action :install
  end
end

# iptablesの無効化
service 'iptables' do
  action [:disable, :stop]
end

service 'ip6tables' do
  action [:disable, :stop]
end

# SELinuxの無効化
execute "Disable selinux" do
  only_if "getenforce | egrep -qx Enforcing"
  command "setenforce 0"
  action :run
  notifies :create, "template[/etc/selinux/config]"
end

template "/etc/selinux/config" do
  source "selinux.erb"
  variables(
    :selinux => "disabled",
    :selinuxtype => "targeted"
  )
  action :nothing
end

# 不要となることが多いサービスを無効化する
%w[acpid auditd autofs avahi-daemon avahi-dnsconfd bluetooth conman cpuspeed cups dnsmasq dund gpm hidd ip6tables irda lvm2-monitor mcstrans mdmonitor multipathd pand pcscd psacct rawdevices readahead_early readahead_later restorecond saslauthd smartd wpa_supplicant ypbind yum-updatesd].each do |name|
  service name do
    ignore_failure true
    action [:disable, :stop]
  end
end

# CDH4
remote_file "/etc/yum.repos.d/cloudera-cdh4.repo" do
  source "http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/cloudera-cdh4.repo"
  owner  "root"
  mode   00644
  action :create_if_missing
end

package 'hadoop-0.20-conf-pseudo' do
  action :install
end

# HDFSの初期化と起動
bash "Format Namenode" do
  not_if { ::File.exists?('/var/lib/hadoop-hdfs/cache/hdfs/dfs/name') }
  user  'hdfs'
  code <<-EOC
    hdfs namenode -format
  EOC
end

# HDFS起動
service 'hadoop-hdfs-namenode' do
  action [:enable, :start]
end

service 'hadoop-hdfs-datanode' do
  action [:enable, :start]
end


# Hadoop実行用のディレクトリ作成
bash "Create tmp directory for Hadoop" do
  not_if 'hadoop fs -ls /tmp'
  user  'hdfs'
  code <<-EOC
    hadoop fs -mkdir /tmp
    hadoop fs -chmod -R 1777 /tmp
  EOC
end

bash "Create mapred directory for Hadoop" do
  not_if 'hadoop fs -ls /var/lib/hadoop-hdfs/cache/mapred/mapred/staging'
  user  'hdfs'
  code <<-EOC
    hadoop fs -mkdir -p /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
    hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
    hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred
  EOC
end

# MapReduce起動
service 'hadoop-0.20-mapreduce-jobtracker' do
  action [:enable, :start]
end

service 'hadoop-0.20-mapreduce-tasktracker' do
  action [:enable, :start]
end

# ユーザ用のディレクトリ作成
bash "Create User Directory" do
  user 'hdfs'
  code <<-EOC
    hadoop fs -mkdir /user/vagrant
    hadoop fs -chown vagrant /user/vagrant
  EOC
end

# Running an example application with MRv1
bash "Running an example application with MRv1" do
  user 'vagrant'
  code <<-EOC
    hadoop fs -rm -r -f input
    hadoop fs -mkdir input
    hadoop fs -put /etc/hadoop/conf/*.xml input
    hadoop fs -rm -r -f output
    /usr/bin/hadoop jar /usr/lib/hadoop-0.20-mapreduce/hadoop-examples.jar grep input output 'dfs[a-z.]+'
  EOC
end
