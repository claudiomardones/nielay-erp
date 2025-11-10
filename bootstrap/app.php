<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withProviders([
        \App\Providers\Filament\AdminPanelProvider::class,
    ])
    ->withMiddleware(function (Middleware $middleware) {
        // GLOBAL: Aplicar a TODAS las rutas
        $middleware->append(\App\Http\Middleware\SecurityHeaders::class);
        
        // Middleware stack web
        $middleware->web(append: [
            \App\Http\Middleware\SetTenantContext::class,
            'throttle:60,1',
        ]);

        // Rate Limiting API
        $middleware->throttleApi(60);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })
    ->create();