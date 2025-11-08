<?php

namespace App\Traits;

use Illuminate\Database\Eloquent\Builder;

trait TenantScoped
{
    protected static function bootTenantScoped(): void
    {
        static::addGlobalScope('tenant', function (Builder $query) {
            $tenantId = session('tenant_id', 0);
            
            if ($query->getQuery()->columns === null || 
                !in_array('tenant_id', $query->getQuery()->columns)) {
                $query->where($query->getModel()->getTable() . '.tenant_id', $tenantId);
            }
        });
    }
    
    public static function withoutTenantScope(): Builder
    {
        return static::withoutGlobalScope('tenant');
    }
}