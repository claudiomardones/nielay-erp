<?php

namespace App\Traits;

use Illuminate\Support\Facades\DB;

trait Auditable
{
    protected static function bootAuditable()
    {
        static::created(function ($model) {
            self::logAudit('created', $model);
        });

        static::updated(function ($model) {
            self::logAudit('updated', $model);
        });

        static::deleted(function ($model) {
            self::logAudit('deleted', $model);
        });
    }

    protected static function logAudit($event, $model)
    {
        try {
            DB::table('newenia_security_audit.audit_logs')->insert([
                'tenant_id' => $model->tenant_id ?? 0,
                'actor_user_id' => auth()->id(),
                'event' => $event,
                'ref_table' => $model->getTable(),
                'ref_id' => $model->getKey(),
                'meta' => json_encode([
                    'model' => get_class($model),
                    'changes' => $model->getDirty(),
                    'ip' => request()->ip(),
                    'user_agent' => request()->userAgent()
                ]),
                'created_at' => now()
            ]);
        } catch (\Exception $e) {
            \Log::error('Audit log failed: ' . $e->getMessage());
        }
    }
}