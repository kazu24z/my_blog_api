# Dockerfile
FROM --platform=linux/arm64 ruby:3.2.2

# 必要なライブラリのインストール
RUN apt-get update -qq && apt-get install -y nodejs default-libmysqlclient-dev yarn

# 作業ディレクトリの作成
RUN mkdir /app
WORKDIR /app

# ホストの Gemfile と Gemfile.lock をコンテナにコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# bundler のインストール
RUN gem install bundler

# Gem のインストール
RUN bundle install

# すべてのファイルをコンテナにコピー
COPY . /app

# コンテナのポートを開放
EXPOSE 3000

# サーバを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
