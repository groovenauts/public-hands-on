ハンズオン
===================

# ハンズオンの概要

## 何を実現するのか

仮想マシン上にHadoopの擬似分散環境をセットアップし、Hadoopのジョブが投入出来る状態をつくる

### 何をやるかの詳細

1. 仮想マシンを立ち上げる
   ネットワークはブリッジ接続とする

2. Hadoopの擬似分散環境のセットアップ

```
  - JDK のインストール
  - perl, vim のインストール
  - iptables の無効化
  - SELinux の無効化
  - CDH4 のインストール
  - HDFS のフォーマット
  - HDFS のデーモン起動
  - Hadoop 実行用のディレクトリ作成
  - MapReduce のデーモン起動
  - Hadoop ジョブ実行用のユーザを作成
```

3. 実際にHadoopジョブを実行してみて、正しくセットアップが行われたことを確認

## どのような手順で行うか

1. 仮想マシンの起動
2. 仮想マシンへのSSH接続設定
3. knife の初期設定
4. リポジトリ（キッチン）の作成
5. 仮想マシン側のChefの設定
6. Hadoop 擬似分散環境のセットアップ用Cookbookの作成
7. JDKセットアップ用のCookbookをダウンロードして使えるようにする
8. serverspecの初期設定
9. serverspecに仕様の記述をおこなう
10. テストが失敗することを確認
11. Hadoop 擬似分散環境のセットアップ用レシピを書く
12. レシピを適用
13. serverspecで正しくセットアップが行われたことを確認

### 仮想マシンの起動

```
mkdir -p ~/gn-public-hands-on/vagrant && cd $_ # Vagrant用に任意のディレクトリを作成

# CentOS 6.4 (64bit) のイメージをインストール
# vagrant box add cent64 http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box
# が既に行われていること
vagrant init cent64

# ブリッジネットワークとします
perl -p -i.bak -e 's/# config.vm.network :bridged/config.vm.network :bridged/' Vagrantfile

# 必要であれば Vagrantfileを編集してください。以下はその例
# Vagrant::Config.run do |config|
#  .....
#  config.vm.customize do |vm|
#    vm.memory_size = 2048
#    vm.name = "hadoop-pseudo"
#  end
# end

# 仮想マシンを起動
vagrant up
```

#### 仮想マシンの一時停止と削除

```
$ vagrant halt    # 一時停止
$ vagrant destroy # 削除
```

### 仮想マシンへのSSH接続設定

今回はホスト名を、「hadoop-pseud」とします

```
vagrant ssh-config --host hadoop-pseudo >> ~/.ssh/config
ssh hadoop-pseudo
```

### knife の初期設定

```
knife configure

vi ~/.chef/knife.rb
knife[:solo_path] = '/tmp/chef-solo'

```

### リポジトリ（キッチン）の作成

```
cd ~/gn-public-hands-on
knife solo init chef-hadoop
cd chef-hadoop
git init && git add . && git commit -m 'first commit'
```

### 仮想マシン側のChefの設定

```
knife solo prepare hadoop-pseudo
git add nodes/hadoop-pseudo.json
git commit -m "ass node json file"
```

### Hadoop 擬似分散環境のセットアップ用Cookbookの作成

```
knife cookbook create hadoop-pseudo -o site-cookbooks
```

### JDKセットアップ用のCookbookをダウンロードして使えるようにする

```
# Opscode Community にサインアップして、秘密鍵を取得し以下のファイルに保存
# ファイル名は各自読み替えてください
vi ~/.chef/taigou.pem
chmod 600 ~/.chef/taigou.pem

# knifeの設定ファイルを編集
# 秘密鍵のファイル名は各自読み替えてください
vi ~/.chef/knife.rb
client_key '/Users/taigou/.chef/taigou.pem'
cookbook_path [ './cookbooks ' ]

# knifeでjavaクックブックの取得
cd ~/gn-public-hands-on
git status # コミットしていないものがあったらコミットしてください
knife cookbook site vendor java

# ブランチが切られて、コミットされるので
git status
git branch
git checkout master
git merge ....
git add .
git commit -m ""

# run_listに追加
vi nodes/hadoop-pseudo.json
```

### serverspecの初期設定

```
serverspec-init
Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 1

Vagrant instance y/n: y
Input vagrant instance name: hadoop-pseudo
 + spec/
 + spec/hadoop-pseudo/
 + spec/hadoop-pseudo/httpd_spec.rb
 + spec/spec_helper.rb
 + Rakefile

# httpd_spec.rbがデフォルトで作成されるのでファイル名変更
git mv spec/hadoop-pseudo/httpd_spec.rb spec/hadoop-pseudo/hadoop-pseudo_spec.rb
git add .
git commit -m ""
```

### serverspecに仕様の記述をおこなう

```
vi spec/hadoop-pseudo/hadoop-pseudo_spec.rb
git add .
git commit -m ""
```

[serverspec_for_hadoop-pseudo](https://github.com/groovenauts/public-hands-on/blob/master/02/hadoop-pseudo_spec.rb)

### テストが失敗することを確認

```
rake spec
```

### Hadoop 擬似分散環境のセットアップ用レシピを書く

```
vi site-cookbooks/hadoop-pseudo/recipes/default.rb
git add .
git commit -m ""
```

[recipe_for_hadoop-pseudo](https://github.com/groovenauts/public-hands-on/blob/master/02/recipe_for_hadoop-pseudo.rb)

### レシピを適用

```
knife solo cook hadoop-pseudo
```

### serverspecで正しくセットアップが行われたことを確認

```
rake spec
```