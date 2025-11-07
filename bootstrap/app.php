<?php
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(__DIR__ . '/..')
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
    )
        ->withProviders([\App\Providers\Filament\AdminPanelProvider::class])
    ->withMiddleware(function (Middleware $middleware) {
        // middlewares globales (si los necesitas, después)
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
