<?php

namespace App\Providers;

use Illuminate\Database\Eloquent\Model;
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
        // macro to alias images with Vite::image(...) in blade templates
        Vite::macro('image', fn (string $asset) => $this->asset("resources/images/{$asset}"));
        // macro to alias fonts with Vite::font(...) in blade templates
        Vite::macro('font', fn (string $asset) => $this->asset("resources/fonts/{$asset}"));

        // As these are concerned with application correctness,
        // leave them enabled all the time.
        Model::preventAccessingMissingAttributes();
        Model::preventSilentlyDiscardingAttributes();

        // Since this is a performance concern only, don’t halt
        // production for violations.
        Model::preventLazyLoading(! $this->app->isProduction());
    }
}
