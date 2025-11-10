<?php

namespace App\Listeners;

use App\Models\AuditLog;
use Illuminate\Auth\Events\Failed;

class LogFailedLogin
{
    /**
     * Handle the event.
     */
    public function handle(Failed $event): void
    {
        AuditLog::create([
            'user_id' => null, // No hay usuario autenticado
            'user_email' => $event->credentials['email'] ?? null,
            'action' => 'login_failed',
            'auditable_type' => null,
            'auditable_id' => null,
            'old_values' => null,
            'new_values' => null,
            'ip_address' => request()->ip(),
            'user_agent' => request()->userAgent(),
            'metadata' => [
                'attempted_email' => $event->credentials['email'] ?? 'unknown',
                'failed_at' => now()->toDateTimeString(),
            ],
            'tenant_id' => 0,
        ]);
    }
}