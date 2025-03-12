# ベースイメージ
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

# 作業ディレクトリを設定
WORKDIR /app

# 環境変数を設定
ENV APP_HOST="omikuji-414350596159.asia-northeast1.run.app"
ENV PORT=8080

# Gemfile をコピー
COPY Gemfile Gemfile.lock /app/

# Bundler をインストール
RUN gem install bundler && bundle install

# アプリのコードをコピー
COPY . /app

# ポートを公開
EXPOSE 8080

# Rails サーバを起動（マイグレーションを実行してから）
CMD ["sh", "-c", "bin/rails db:migrate && bin/rails db:seed && exec bundle exec rails server -b 0.0.0.0 -p $PORT"]

