# amq_docker
**備忘録**：ActiveMQ-Artemisでクラスターを構成して非同期メッセージングの実験

## コンポーズファイルについて
コンテナを３つ作成して、クラスターを構成する。
  - コンテナ１(node1)
    - http://localhost:8081
  - コンテナ２(node2)
    - http://localhost:8082
  - コンテナ３(node3)
    - http://localhost:8083

## 起動について
```
docker compose build
docker compose up -d
```
コンテナのエントリーポイントは[/opt/activemq-artemis/docker/docker-run.sh](./docker-run.sh)  
ここでブローカーを初期化している。初期化処理で /etc/broker.xmlを生成している。docker run実行時のARGで初期化に必要なパラメータを指定する。
  - ARTEMIS_USER : アドミニストレーターのユーザー名（デフォルト：artemis）
  - ARTEMIS_PASSWORD : アドミニストレーターのパスワード（デフォルト：artemis）
  - ANONYMOUS_LOGIN : 匿名ログインを許可するかどうか（デフォルト：false）
  - EXTRA_ARGS : ブローカーの起動時に渡す引数（デフォルト：--http-host 0.0.0.0 --relax-jolokia）


docker-run.shは、ブローカーを初期化した後、./etc-overrideにあるファイルを/etcにコピーするようなので、ここにカスタム設定のbroker.xmlを置いておくと良さそうだ。


### EXTRA_ARGSの例
EXTRA_ARGSはartemis createコマンドの引数と同じものを指定する。  

### トランスポートに関する設定
[ユーザマニュアル・トランスポート](https://activemq.apache.org/components/artemis/documentation/latest/configuring-transports.html#configuring-the-transport)

  - アクセプターは他のサーバーからの接続を受け付ける（受信の設定）
  - コネクターは他のサーバへ接続する(送信の設定)
  - Nettyトランスポートを使用する


### クラスターに関する設定
[ユーザーマニュアル・クラスター](https://activemq.apache.org/components/artemis/documentation/latest/clusters.html#clusters)


  - コネクターはクライアント（または他のサーバー）が接続するための設定
  - ブロードキャストグループはサーバーがネットワーク経由でコネクタをブロードキャストする手段
  - ブロードキャストグループはUDPまたはJGroupsを使用してコネクターペアをブロードキャストする
  - ディスカバリーグループはブロードキャスト エンドポイント (UDP マルチキャスト アドレスまたは JGroup チャネル) からコネクタ情報を受信する方法を定義


# コマンドラインでの操作
## コマンドラインツールの起動
```
docker exec -it node1 /var/lib/artemis-instance/bin/artemis shell --user admin --password admin
```
接続するサーバーを聞かれるので、node1に接続する場合は以下のように入力する。
```
tcp://node1:61616
``` 
