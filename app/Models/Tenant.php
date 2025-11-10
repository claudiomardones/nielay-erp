<?php

namespace App\Models;

use App\Traits\Auditable;
use App\Traits\TenantScoped;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tenant extends Model
{
    use HasFactory, Auditable;

    protected $table = 'newenia_global_core.tenants';
    protected $primaryKey = 'id';

    protected $fillable = [
        'code',
        'name',
        'status',
    ];

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($tenant) {
            if (empty($tenant->code)) {
                $tenant->code = 'TEN-' . strtoupper(substr(uniqid(), -6));
            }
            if (empty($tenant->status)) {
                $tenant->status = 'active';
            }
        });
    }

    public function users()
    {
        return $this->hasMany(User::class, 'tenant_id', 'id');
    }
}