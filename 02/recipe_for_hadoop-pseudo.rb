#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#0. パッケージのインストール
%w(perl vim).each do |p|
  package p do
    action :install
  end
end

#1. iptablesの無効化
service 'iptables' do
  action [:disable, :stop]
end

service 'ip6tables' do
  action [:disable, :stop]
end

#2. SELinuxの無効化
bash "Disable SELinux" do
  user  'vagrant'
  cwd   '/home/vagrant'
  code <<-EOC
    setenforce 0
    perl -p -i.bak -e 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
  EOC
end

#3. Oracle JDK

#4. CDH4
bash "Download cloudera-cdh4.repo" do
  user  'root'
  cwd   '/etc/yum.repos.d'
  code <<-EOC
    wget http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/cloudera-cdh4.repo
  EOC
end

package 'hadoop-0.20-conf-pseudo' do
  action :install
end

#5. HDFSの初期化と起動
bash "Format Namenode" do
  not_if 'ls /var/lib/hadoop-hdfs/cache/hdfs/dfs/name'
  user  'hdfs'
  code <<-EOC
    hdfs namenode -format
  EOC
end

#6. HDFS起動
bash "Start HDFS Daemons" do
  user  'root'
  cwd   '/etc/init.d'
  code <<-EOC
    for x in `ls hadoop-hdfs-*`; do service $x start; done
  EOC
end

#6. Hadoop実行用のディレクトリ作成
bash "Create directories for Hadoop" do
  user  'hdfs'
  code <<-EOC
    hadoop fs -mkdir /tmp
    hadoop fs -chmod -R 1777 /tmp
    hadoop fs -mkdir -p /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
    hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
    hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred
  EOC
end

#7. MapReduce起動
bash "Start HDFS Daemons" do
  user  'root'
  cwd   '/etc/init.d'
  code <<-EOC
    for x in `ls hadoop-0.20-mapreduce-*`; do service $x start; done
  EOC
end

#8. ユーザ用のディレクトリ作成
bash "Create User Directory" do
  user  'hdfs'
  code <<-EOC
    hadoop fs -mkdir /user/vagrant
    hadoop fs -chown vagrant /user/vagrant
  EOC
end

#9. Running an example application with MRv1
bash "Running an example application with MRv1" do
  user  'vagrant'
  code <<-EOC
    hadoop fs -mkdir input
    hadoop fs -put /etc/hadoop/conf/*.xml input
    hadoop fs -rm -r -f output
    /usr/bin/hadoop jar /usr/lib/hadoop-0.20-mapreduce/hadoop-examples.jar grep input output 'dfs[a-z.]+'
  EOC
end
