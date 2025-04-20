FROM ruby:3.3.6

# 必要なパッケージと gsutil のインストール
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      curl gnupg ca-certificates python3-pip sqlite3 build-essential nodejs wget && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-456.0.0-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-456.0.0-linux-x86_64.tar.gz && \
    ./google-cloud-sdk/install.sh --quiet && \
    ./google-cloud-sdk/bin/gcloud components install gsutil --quiet && \
    mv google-cloud-sdk /opt/ && \
    ln -s /opt/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil

# Bundler & Rails
RUN gem install bundler --no-document && \
    gem install rails --no-document

ENV PORT=80

# 作業ディレクトリ
WORKDIR /app

# Gemfile を先にコピーして依存解決
COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs=4 --retry=3

# アプリケーション全体をコピー
COPY . /app

HEALTHCHECK --interval=5s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:80/up || exit 1

EXPOSE 80

# assetsはビルド時にまとめて作っておく
RUN bundle exec rails assets:precompile

CMD ["bash", "-c", "bundle exec puma -C config/puma.rb"]
