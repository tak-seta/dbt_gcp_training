# 前半で requirements.txt を作成、後半でそれを用いて Python アプリケーションの載った Docker Image を作成
# poetry.lock を読むためには Poetry をインストールする必要がある一方、
# アプリケーションが載るコンテナには Poetry を入れておく必要がないため、これらを切り離したいという意図

# 前半
# Docker のキャッシュ戦略をうまく使うため、一番最初に Poetry をインストール。
# こうすることで、ビルドのたびに Poetry をインストールする手間が省ける。
# 次に、pyproject.toml と poetry.lock だけをコピーして、requirements.txt を生成

# pyenv localに合わせて3.9.13を指定していますが、ご自由に
FROM python:3.10.12-slim as builder

WORKDIR /app

RUN pip install poetry

COPY pyproject.toml poetry.lock ./

RUN poetry export --without-hashes -f requirements.txt --output requirements.txt

# 後半
# できあがった requirements.txt を前半部分からコピーしてきた上で、
# pip コマンドを使ってそれらのパッケージを全てインストール。
# もしこれらのファイルに変更がない場合はキャッシュが使われて自動で次のレイヤのビルドが行われる。
# インストールが終わった後に、各種 Python スクリプトを転送して、その他コマンドなどを書いて完成
FROM python:3.10.12-slim

# 環境変数を引数で受け取り、環境変数へ突っ込む
# dbtのprofiles.ymlで環境毎の接続情報を"outputs"で定義し
# "target"で "{{ env_var('ENV') }}" と
# 指定すると環境によってプロジェクトまたはデータセットを変更できる
ARG env
ENV ENV=${env}

ENV PYTHONUNBUFFERED=1
ENV TZ='Asia/Tokyo'

WORKDIR /app

COPY --from=builder /app/requirements.txt .

RUN pip install -U pip
RUN pip install -r requirements.txt

COPY . /app

# dbtの追加パッケージをインストール
WORKDIR /app/dbt_transform
RUN dbt deps --profiles-dir .
WORKDIR /app
