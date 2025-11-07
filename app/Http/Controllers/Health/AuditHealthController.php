<?php

namespace App\Http\Controllers\Health;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Routing\Controller;

class AuditHealthController extends Controller
{
    public function __invoke(Request $request)
    {
        // Top 10 tenants por requests (últimos 7 días)
        $top = DB::select("
            SELECT tenant_id, COUNT(*) AS total
            FROM newenia_security_audit.audit_requests
            WHERE created_at >= NOW() - INTERVAL '7 days'
            GROUP BY tenant_id
            ORDER BY total DESC
            LIMIT 10
        ");

        // Resumen 24h
        $summary24h = DB::selectOne("
            SELECT
              COUNT(*)                              AS total_24h,
              COUNT(*) FILTER (WHERE method='GET')  AS get_24h,
              COUNT(*) FILTER (WHERE method='POST') AS post_24h
            FROM newenia_security_audit.audit_requests
            WHERE created_at >= NOW() - INTERVAL '24 hours'
        ");

        // Últimos 20 paths (sin assets)
        $lastPaths = DB::select("
            SELECT tenant_id, method, path, ip, duration_ms, created_at
            FROM newenia_security_audit.audit_requests
            WHERE created_at >= NOW() - INTERVAL '24 hours'
              AND path !~* '\\.(css|js|map|png|jpg|jpeg|gif|svg|ico|webp|woff2?|ttf|eot)$'
            ORDER BY created_at DESC
            LIMIT 20
        ");

        return response()->json([
            'top_tenants_7d' => $top,
            'summary_24h'    => $summary24h,
            'last_paths'     => $lastPaths,
            'timestamp'      => now()->toIso8601String(),
        ]);
    }
}
