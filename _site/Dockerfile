FROM ruby:3.1-slim

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

# Expose Jekyll's default port
EXPOSE 4000

# Run Jekyll server
# Use 0.0.0.0 to allow connections from outside the container
CMD ["sh", "-c", "bundle exec jekyll serve --host 0.0.0.0"]