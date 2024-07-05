#!/usr/bin/env bash

# helper function to verify that all args passed to it received a value of "y"
# of "Y" to confirm that I want to perform an action
confirmed() {
  for check in "$@"; do
    if [[ -n $check ]] && [[ $check == [yY] ]]; then
      return 0
    else
      return 1
    fi
  done
}

# check if I used a starter kit, and convert this into a variable that tells me
# if I didn't use a starter kit, since that's the check that I want to confirm
# throughout this script
echo 'Did you use a Laravel starter kit? (i.e. Breeze or Jetstream)'
read used_starter_kit
no_starter_kit=""
if confirmed $used_starter_kit; then
  no_starter_kit=""
else
  no_starter_kit="y"
fi

# add the debugbar and ide-helper plugins
composer require --dev barryvdh/laravel-debugbar barryvdh/laravel-ide-helper

# add Livewire
echo 'Should we install Livewire? (y/n)'
read add_livewire
if confirmed $no_starter_kit $add_livewire; then
  composer require livewire/livewire

  # add Livewire Volt
  echo 'Should we add Livewire Volt too?'
  read add_volt
  if confirmed $add_volt; then
    composer require livewire/volt
    php artisan volt:install
  fi
fi

# use the ide-helper plugin to generate documentation for Models and metadata
# for phpstorm and any other ide/text-editor
ide_eloquent='php artisan ide-helper:eloquent -n'
ide_generate='php artisan ide-helper:generate -W'
ide_model='php artisan ide-helper:model -M'
eval "$ide_eloquent"
eval "$ide_generate"
eval "$ide_model"
echo '_ide_helper.php' >> .gitignore
echo '_ide_helper_models.php' >> .gitignore

# copy over the pint formatter config file and .editorconfig file
cp -v "$XDG_CONFIG_HOME/laravel/pint.json" .
cp -v "$XDG_CONFIG_HOME/laravel/.editorconfig" .

# install npm dependencies
npm i

# add https://github.com/shufo/blade-formatter to project to format blade files
# and fill the `$composer_scripts` variable with various scripts to run on
# source files, depending on whether I requested to use install the blade
# formatter or not
add_blade_fmt=""
ide_eloquent='php artisan ide-helper:eloquent -n'
ide_generate='php artisan ide-helper:generate -W'
ide_model='php artisan ide-helper:model -M'
ide_helper_script="\"ide\": [\n"
ide_helper_script="$ide_helper_script\t\"@$ide_eloquent\",\n"
ide_helper_script="$ide_helper_script\t\"@$ide_generate\",\n"
ide_helper_script="$ide_helper_script\t\"@$ide_model\"\n"
ide_helper_script="$ide_helper_script]"
composer_scripts=""
if confirmed $add_blade_fmt; then
  npm i -D blade-formatter
  cp -v "$XDG_CONFIG_HOME/laravel/.bladeformatterrc.json" .

  format_script='"format": "composer format:blade; composer format:php"'
  format_blade_script='"format:blade": "./node_modules/.bin/blade-formatter resources/views/**/*.blade.php -w"'
  format_php_script='"format:php": "./vendor/bin/pint"'
  composer_scripts="$format_script,$format_blade_script,$format_php_script,$ide_helper_script"
else
  format_script='"format": "./vendor/bin/pint"'
  composer_scripts="$format_script,$ide_helper_script"
fi

# add formatting scripts and ide-helper script to composer.json using `jq`
jq --indent 4 \
  ".scripts += { $composer_scripts }" \
  composer.json > composer.tmp.json
mv composer.tmp.json composer.json

# install tailwind and configure it to be processed by Vite
echo 'Should we install Tailwind? (y/n)'
read add_tailwind
if confirmed $no_starter_kit $add_tailwind; then
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
if confirmed $no_starter_kit; then
  mkdir -pv resources/views/components
  cp -v "$XDG_CONFIG_HOME/laravel/layout.blade.php" resources/views/components/layout.blade.php
  cp -v "$XDG_CONFIG_HOME/laravel/welcome.blade.php" resources/views/welcome.blade.php
fi

# use Pint to format all files and add strict type checks to all files
./vendor/bin/pint app/
