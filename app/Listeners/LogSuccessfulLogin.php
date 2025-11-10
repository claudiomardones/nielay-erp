<?php

namespace App\Listeners;

use App\Models\AuditLog;
use Illuminate\Auth\Events\Login;

class LogSuccessfulLogin
{
    /**
     * Handle the event.
     */
    public function handle(Login $event): void
    {
        AuditLog::create([
            'user_id' => $event->user->id,
            'user_email' => $event->user->email,
            'action' => 'login_success',
            'auditable_type' => get_class($event->user),
            'auditable_id' => $event->user->id,
            'old_values' => null,
            'new_values' => null,
            'ip_address' => request()->ip(),
            'user_agent' => request()->userAgent(),
            'metadata' => [
                'remember' => $event->remember ?? false,
                'login_at' => now()->toDateTimeString(),
            ],
            'tenant_id' => session('tenant_id', 0),
        ]);
    }
}