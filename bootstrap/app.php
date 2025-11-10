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
        // ⭐ CRÍTICO: SetTenantContext para multi-tenancy con RLS
        $middleware->web(append: [
            \App\Http\Middleware\SetTenantContext::class,
        ]);

        // 🛡️ SEGURIDAD: Rate Limiting - Prevenir ataques de fuerza bruta
        $middleware->throttleApi(60); // API: 60 requests/minuto
        
        // Rate limiting personalizado para rutas web
        $middleware->web(append: [
            'throttle:60,1', // Web: 60 requests por minuto
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })
    ->create();