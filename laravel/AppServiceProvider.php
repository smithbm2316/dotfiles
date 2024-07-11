<?php

declare(strict_types=1);

namespace App\Providers;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Events\ConnectionEstablished;
use Illuminate\Database\SQLiteConnection;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider {
    /**
     * Register any application services.
     */
    public function register(): void {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void {
        /**
         * macro to alias images with Vite::image(...) in blade templates
         *
         * @disregard P1013
         */
        Vite::macro('image', fn (string $asset) => $this->asset("resources/images/{$asset}"));

        /**
         * macro to alias fonts with Vite::font(...) in blade templates
         *
         * @disregard P1013
         */
        Vite::macro('font', fn (string $asset) => $this->asset("resources/fonts/{$asset}"));

        /**
         * As these are concerned with application correctness,
         * leave them enabled all the time.
         */
        Model::preventAccessingMissingAttributes();
        Model::preventSilentlyDiscardingAttributes();

        /**
         * Since this is a performance concern only, don’t halt production for
         * violations.
         *
         * @disregard P1013
         */
        Model::preventLazyLoading(! $this->app->isProduction());

        /**
         * Listen for a new connection to the SQLite database and update the
         * necessary default settings for the database.
         *
         * @see https://github.com/laravel/framework/pull/52052#issue-2394196559
         */
        Event::listen(function (ConnectionEstablished $event) {
            if ($event->connection instanceof SQLiteConnection) {
                $event->connection->statement(<<<'sql'
                    pragma busy_timeout = 5000;
                    pragma journal_mode = wal;
                    pragma synchronous = normal;
                    pragma foreign_keys = on;
                sql);
            }
        });
    }
}
