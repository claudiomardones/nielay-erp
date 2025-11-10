<?php

namespace App\Traits;

use App\Models\AuditLog;
use Illuminate\Support\Facades\Auth;

trait Auditable
{
    /**
     * Boot del trait - registra eventos automáticamente
     */
    public static function bootAuditable()
    {
        // Evento: Modelo creado
        static::created(function ($model) {
            AuditLog::create([
                'user_id' => Auth::id(),
                'user_email' => Auth::user()?->email,
                'action' => 'created',
                'auditable_type' => get_class($model),
                'auditable_id' => $model->getKey(),
                'old_values' => null,
                'new_values' => $model->getAttributes(),
                'ip_address' => request()->ip(),
                'user_agent' => request()->userAgent(),
                'tenant_id' => session('tenant_id', 0),
            ]);
        });

        // Evento: Modelo actualizado
        static::updated(function ($model) {
            $changes = $model->getDirty();
            
            // Solo loguear si hay cambios reales
            if (!empty($changes)) {
                $original = $model->getOriginal();
                
                AuditLog::create([
                    'user_id' => Auth::id(),
                    'user_email' => Auth::user()?->email,
                    'action' => 'updated',
                    'auditable_type' => get_class($model),
                    'auditable_id' => $model->getKey(),
                    'old_values' => array_intersect_key($original, $changes),
                    'new_values' => $changes,
                    'ip_address' => request()->ip(),
                    'user_agent' => request()->userAgent(),
                    'tenant_id' => session('tenant_id', 0),
                ]);
            }
        });

        // Evento: Modelo eliminado
        static::deleted(function ($model) {
            AuditLog::create([
                'user_id' => Auth::id(),
                'user_email' => Auth::user()?->email,
                'action' => 'deleted',
                'auditable_type' => get_class($model),
                'auditable_id' => $model->getKey(),
                'old_values' => $model->getAttributes(),
                'new_values' => null,
                'ip_address' => request()->ip(),
                'user_agent' => request()->userAgent(),
                'tenant_id' => session('tenant_id', 0),
            ]);
        });
    }

    /**
     * Obtener todos los logs de auditoría de este modelo
     */
    public function auditLogs()
    {
        return $this->morphMany(AuditLog::class, 'auditable');
    }

    /**
     * Obtener el último log de auditoría
     */
    public function lastAuditLog()
    {
        return $this->auditLogs()->latest()->first();
    }
}