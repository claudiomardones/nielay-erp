<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

class SetTenantContext
{
    public function handle(Request $request, Closure $next): Response
    {
        // Obtener tenant_id del usuario autenticado o default 0
        $tenantId = auth()->check() 
            ? (auth()->user()->current_tenant_id ?? 0) 
            : 0;
        
        // Establecer contexto PostgreSQL para RLS
        try {
            DB::statement(
                "SELECT newenia_global_core.set_tenant_id(?)", 
                [$tenantId]
            );
        } catch (\Exception $e) {
            // Si la función no existe aún, continuar
            \Log::warning("set_tenant_id function not found: " . $e->getMessage());
        }
        
        // Registrar en sesión para Global Scope
        session(['tenant_id' => $tenantId]);
        
        return $next($request);
    }
}