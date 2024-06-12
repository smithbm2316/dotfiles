#!/usr/bin/env bash

print_usage() {
  echo "Add various default configurations to a project created with 'laravel new'"
  echo "Usage:"
  echo "  -n  no-starter-kit: Scaffold this project as if we aren't using Laravel Breeze"
  echo "  -h  help: See this usage menu"
}

# setup flags
no_starter_kit=""
while getopts "nh" flag; do
  case "${flag}" in
    n) no_starter_kit="true"
      echo "Scaffolding project without Breeze."
      ;;
    h) print_usage
      exit 1 ;;
    *) print_usage
      exit 1 ;;
  esac
done

# add the debugbar and ide-helper plugins
composer require --dev barryvdh/laravel-debugbar barryvdh/laravel-ide-helper

# add livewire and livewire Volt (if not using Breeze)
if [ "$no_starter_kit" = "true" ]; then
  composer require livewire/livewire livewire/volt
  php artisan volt:install
fi

# use the ide-helper plugin to generate documentation for Models and metadata
# for phpstorm and any other ide/text-editor
php artisan ide-helper:generate
php artisan ide-helper:meta
php artisan ide-helper:models --write

# copy over the proper formatter config files
cp -v "$XDG_CONFIG_HOME/laravel/.bladeformatterrc.json" .
cp -v "$XDG_CONFIG_HOME/laravel/pint.json" .

# install npm dependencies
npm i
# add https://github.com/shufo/blade-formatter to project to format blade files
npm i -D blade-formatter

# add formatting scripts to composer.json using `jq`
format_script='"format": "composer format:blade; composer format:php"'
format_blade_script='"format:blade": "./node_modules/.bin/blade-formatter resources/views/**/*.blade.php -w"'
format_php_script='"format:php": "./vendor/bin/pint -v"'
jq --indent 4 \
  ".scripts += { $format_script,$format_blade_script,$format_php_script }" \
  composer.json > composer.tmp.json
mv composer.tmp.json composer.json

# install tailwind and configure it to be processed by Vite
if [ "$no_starter_kit" = "true" ]; then
  npm i -D tailwindcss postcss autoprefixer
  npx tailwindcss init -p
  cp -v "$XDG_CONFIG_HOME/laravel/tailwind.config.js" tailwind.config.js
  cp -v "$XDG_CONFIG_HOME/laravel/app.css" resources/css/app.css
  cp -v "$XDG_CONFIG_HOME/laravel/app.js" resources/js/app.js
fi

# overwrite app/Providers/AppServiceProvider with strict defaults and some Vite
# macros/aliases for using Vite::image(...) and Vite::font(...) to point to the
# resources/images and resources/fonts directories
cp -v "$XDG_CONFIG_HOME/laravel/AppServiceProvider.php" app/Providers/AppServiceProvider.php

# overwrite the default homepage with a default HTML5 layout
if [ "$no_starter_kit" = "true" ]; then
  mkdir -pv resources/views/components
  cp -v "$XDG_CONFIG_HOME/laravel/layout.blade.php" resources/views/components/layout.blade.php
  cp -v "$XDG_CONFIG_HOME/laravel/welcome.blade.php" resources/views/welcome.blade.php
fi

# use Pint to format all files and add strict type checks to all files
./vendor/bin/pint app/
