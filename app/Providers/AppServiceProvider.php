<?php

namespace App\Providers;

use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        // Fuerza HTTPS globalmente incluso si el request llega por proxy
        if (app()->environment(['production', 'staging'])) {
            URL::forceScheme('https');
            $_SERVER['HTTPS'] = 'on';
        }
    }
}
