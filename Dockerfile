FROM ruby:3.3.6

# 必要なパッケージと Chromium（Puppeteer用）、gsutil のインストール
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      curl gnupg ca-certificates python3-pip sqlite3 build-essential nodejs wget chromium fonts-noto-cjk \
      libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libxss1 libasound2 libxcomposite1 libxrandr2 \
      libgbm-dev libgtk-3-0 && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-456.0.0-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-456.0.0-linux-x86_64.tar.gz && \
    ./google-cloud-sdk/install.sh --quiet && \
    ./google-cloud-sdk/bin/gcloud components install gsutil --quiet && \
    mv google-cloud-sdk /opt/ && \
    ln -s /opt/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil

# Bundler & Rails のインストール
RUN gem install bundler --no-document && \
    gem install rails --no-document

# Bun のインストール
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:$PATH"

# 作業ディレクトリ
WORKDIR /app

# Ruby依存のインストール
COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs=4 --retry=3

# Bun依存のインストール
COPY package.json bun.lockb* /app/
RUN bun install

# アプリケーション全体をコピー
COPY . /app

# アセットのプリコンパイル
RUN bundle exec rails assets:precompile

# ヘルスチェック（Fly用）
HEALTHCHECK --interval=5s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:80/up || exit 1

# ポート開放
EXPOSE 80

# Rails起動
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "80"]
