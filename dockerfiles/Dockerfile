FROM php:8.4-fpm-bookworm

LABEL CREATOR="ME"
LABEL DESCRIPTION="Simple Dockerfile for trying Laravel bootcamp"

ARG NODE_VERSION=22.12.0
ARG NPM_VERSION=10.9.0
ARG NVM_VERSION=0.39.0
ENV NVM_DIR=/usr/local/nvm
# intl for internationalization-related tasks, such as formatting numbers, dates, currencies,
#### and other locale-sensitive data
# mbstring for multi-byte string handling
# exif for reading EXIF metadata in images
# pcntl for process control functions
# bcmath for arbitrary precision mathematics
# gd for image manipulation (graphics drawing)
# zip for handling zip file compression
ARG PHP_EXTENSIONS="pdo_mysql mbstring exif pcntl bcmath gd zip intl"

# Install dependencies for NVM, Node.js and other utilities
# curl : for downloading the node.js setup script
# gnupg : for verifying node.js GPG signatures
# ca-certificates : for HTTPS connections
# libpng-dev : lib for handling PNG images, GD extension needs this process PNG files
# libong-dev : lib for regular expressions, mbstring extension requires this for text pattern matching
# libxml2-dev : lib for XML parsing, laravel uses XML in various place, including
####### config files and API responses
# libzip-dev :  required to enable zip support in PHP
# libicu-dev: Development libraries for Unicode and internationalization support, required for the intl PHP extension.
RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    git \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libicu-dev \
    zip unzip \
    && docker-php-ext-install -j$(nproc) ${PHP_EXTENSIONS} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Use nvm for better version management
RUN mkdir -p $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm alias default ${NODE_VERSION} \
    && nvm use default \
    # Link Node.js and npm globally
    && ln -s $NVM_DIR/versions/node/v${NODE_VERSION}/bin/node /usr/local/bin/node \
    && ln -s $NVM_DIR/versions/node/v${NODE_VERSION}/bin/npm /usr/local/bin/npm

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# Set proper permissions for laravel
RUN chown -R www-data:www-data /var/www/html

COPY --chown=www-data:www-data composer.json composer.lock ./

# --no-scripts: Skips running scripts defined in composer.json during installation
# --no-autoloader: Prevents generating the autoloader until we have all files
RUN composer install --no-scripts --no-autoloader

COPY --chown=www-data:www-data package.json package-lock.json ./

# CI is preferred over install for exact version matching
RUN npm ci

# COPY the rest of the application
COPY --chown=www-data:www-data . .

# Generate optimized autoloader files and run post-install scripts
RUN composer dump-autoload --optimize

# Build frontend assets
RUN npm run build

# Set up proper permissions
RUN chown -R www-data:www-data storage bootstrap/cache && \
   chmod -R 755 storage bootstrap/cache


USER www-data
