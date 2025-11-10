<?php

namespace App\Models;

use App\Traits\Auditable;
use App\Traits\TenantScoped;
use Filament\Models\Contracts\FilamentUser;
use Filament\Panel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable implements FilamentUser
{
    use HasFactory, Notifiable, TenantScoped, Auditable;

    /**
     * Campos protegidos contra mass assignment
     * Previene que usuarios maliciosos modifiquen role o tenant_id
     */
    protected $guarded = ['role', 'tenant_id'];

    /**
     * Campos permitidos para mass assignment
     * NOTA: role y tenant_id removidos por seguridad (están en $guarded)
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'current_tenant_id',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    /**
     * Determinar si el usuario puede acceder al panel de Filament
     * TODO: Implementar lógica de permisos más restrictiva
     */
    public function canAccessPanel(Panel $panel): bool
    {
        return true; // Permitir acceso a todos los usuarios
    }
}