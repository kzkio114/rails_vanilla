# Dockerfile
FROM ruby:3.3.6

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y build-essential nodejs sqlite3

# Rails をインストール
RUN gem install rails

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN gem install bundler && bundle install

COPY . /app

# ポートを公開
EXPOSE 4000

# Rails サーバを起動
CMD ["rails", "server", "-b", "0.0.0.0"]