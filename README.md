# amq_docker
ActiveMQでクラスターを構成して非同期メッセージングの実験  
**備忘録**

## コンポーズファイルについて
コンテナを３つ作成して、クラスターを構成する。
  - コンテナ１
    - node1
    - http://localhost:8081
  - コンテナ２
    - node2
    - http://localhost:8082
  - コンテナ３
    - node3
    - http://localhost:8083

## 起動について
コンテナのエントリーポイントは/opt/activemq-artemis/docker/docker-run.shで、ここでブローカーを初期化している。  
この初期化処理で /etc/broker.xmlを生成している。docker run実行時のARGで初期化に必要なパラメータを指定する。
  - ARTEMIS_USER : アドミニストレーターのユーザー名（デフォルト：artemis）
  - ARTEMIS_PASSWORD : アドミニストレーターのパスワード（デフォルト：artemis）
  - ANONYMOUS_LOGIN : 匿名ログインを許可するかどうか（デフォルト：false）
  - EXTRA_ARGS : ブローカーの起動時に渡す引数（デフォルト：--http-host 0.0.0.0 --relax-jolokia）

**EXTRA_ARGSの例**
EXTRA_ARGSはartemis createコマンドの引数と同じものを指定する。  
```
artemis> create help
```
**クラスターに関する設定**
調査中…
