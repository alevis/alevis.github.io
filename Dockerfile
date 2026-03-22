FROM ruby:3.1-slim as base

# Install essential dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN bundle config unset frozen
WORKDIR /app

# Copy dependency files first for better caching
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Install webrick if not in Gemfile (required for Ruby 3.0+)
RUN bundle list | grep -q webrick || bundle add webrick

# Copy application code
COPY . .

# Development stage
FROM base as development

# Expose Jekyll's default port
EXPOSE 4000

# Run Jekyll server
# Use 0.0.0.0 to allow connections from outside the container
CMD ["sh", "-c", "bundle exec jekyll serve --host 0.0.0.0"]

# Production stage - builds static site for GitHub Pages
FROM base as production

# Build Jekyll site for production
RUN bundle exec jekyll build

# Verify the build output
RUN test -d _site || (echo "Build failed: _site directory not found" && exit 1)

# Use a lightweight image to serve the built site
FROM ruby:3.1-slim as production-serve

WORKDIR /app

# Copy built site from production stage
COPY --from=production /app/_site /app/_site

# Install a simple HTTP server
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 4000

# Serve the static site
CMD ["python3", "-m", "http.server", "4000", "--directory", "/app/_site"]