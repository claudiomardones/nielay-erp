<?php

namespace App\Policies;

use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class TenantPolicy
{
    use HandlesAuthorization;

    /**
     * Ver lista de tenants
     * Solo admin sistema o tenant_admin pueden ver lista
     */
    public function viewAny(User $user): bool
    {
        return in_array($user->role ?? 'tenant_user', ['admin', 'tenant_admin']);
    }

    /**
     * Ver un tenant específico
     * Solo si es su propio tenant O es admin sistema
     */
    public function view(User $user, $tenant): bool
    {
        // Si es admin sistema, puede ver todos
        if (($user->role ?? '') === 'admin') {
            return true;
        }

        // Si es su propio tenant
        return $user->tenant_id === ($tenant->id_client ?? 0);
    }

    /**
     * Crear nuevo tenant
     * SOLO admin sistema
     */
    public function create(User $user): bool
    {
        return ($user->role ?? '') === 'admin';
    }

    /**
     * Actualizar tenant
     * Solo su propio tenant O admin sistema
     */
    public function update(User $user, $tenant): bool
    {
        // Admin sistema puede editar todos
        if (($user->role ?? '') === 'admin') {
            return true;
        }

        // Tenant admin puede editar su propio tenant
        if (($user->role ?? '') === 'tenant_admin') {
            return $user->tenant_id === ($tenant->id_client ?? 0);
        }

        return false;
    }

    /**
     * Eliminar tenant
     * SOLO admin sistema (operación crítica)
     */
    public function delete(User $user, $tenant): bool
    {
        return ($user->role ?? '') === 'admin';
    }

    /**
     * Restaurar tenant eliminado
     * SOLO admin sistema
     */
    public function restore(User $user, $tenant): bool
    {
        return ($user->role ?? '') === 'admin';
    }

    /**
     * Eliminar permanentemente
     * SOLO admin sistema
     */
    public function forceDelete(User $user, $tenant): bool
    {
        return ($user->role ?? '') === 'admin';
    }
}