FROM ruby:3.3.6

# 必要なパッケージと gsutil のインストール
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      curl gnupg ca-certificates python3-pip sqlite3 build-essential nodejs wget chromium fonts-noto-cjk && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-456.0.0-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-456.0.0-linux-x86_64.tar.gz && \
    ./google-cloud-sdk/install.sh --quiet && \
    ./google-cloud-sdk/bin/gcloud components install gsutil --quiet && \
    mv google-cloud-sdk /opt/ && \
    ln -s /opt/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil

# Bundler & Rails
RUN gem install bundler --no-document && \
    gem install rails --no-document

# Bun install
RUN curl -fsSL https://bun.sh/install | bash && \
    export PATH="$HOME/.bun/bin:$PATH"

ENV PORT=80
WORKDIR /app

# Rubyの依存解決
COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs=4 --retry=3

# Node.js用パッケージインストール（package.json がある前提）
COPY package.json package-lock.json* /app/
RUN npm install

# アプリケーション全体をコピー
COPY . /app

# assetsプリコンパイル
RUN bundle exec rails assets:precompile

HEALTHCHECK --interval=5s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:80/up || exit 1

EXPOSE 80

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "80"]
