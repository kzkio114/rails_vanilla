# Dockerfile
FROM ruby:3.3.6

# 必要なパッケージをインストール
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        curl gnupg ca-certificates \
    && curl -fsSL https://ftp-master.debian.org/keys/archive-key-11.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/debian-archive-keyring.gpg \
    && apt-get update -qq \
    && apt-get install -y build-essential nodejs sqlite3

# Rails をインストール
RUN gem install rails

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN gem install bundler && bundle install

COPY . /app

# ポートを公開（Cloud Run は 8080 をデフォルトで使用）
EXPOSE 4000

# Rails サーバを起動（$PORT 環境変数を適用）
CMD ["sh", "-c", "rails server -b 0.0.0.0 -p 4000"]
