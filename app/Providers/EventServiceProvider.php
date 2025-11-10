<?php

namespace App\Providers;

use App\Listeners\LogFailedLogin;
use App\Listeners\LogLogout;
use App\Listeners\LogSuccessfulLogin;
use Illuminate\Auth\Events\Failed;
use Illuminate\Auth\Events\Login;
use Illuminate\Auth\Events\Logout;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event listener mappings for the application.
     *
     * 🕵️ AUDIT LOGGING: Registra login/logout/failed attempts
     *
     * @var array<class-string, array<int, class-string>>
     */
    protected $listen = [
        // Login exitoso
        Login::class => [
            LogSuccessfulLogin::class,
        ],

        // Login fallido (intento de ataque)
        Failed::class => [
            LogFailedLogin::class,
        ],

        // Logout
        Logout::class => [
            LogLogout::class,
        ],
    ];

    /**
     * Register any events for your application.
     */
    public function boot(): void
    {
        //
    }

    /**
     * Determine if events and listeners should be automatically discovered.
     */
    public function shouldDiscoverEvents(): bool
    {
        return false;
    }
}