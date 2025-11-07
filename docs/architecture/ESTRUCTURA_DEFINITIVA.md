# 🏗️ ESTRUCTURA DEFINITIVA NIELAY - SILICON VALLEY LEVEL

**Versión:** 1.0 Definitiva  
**Fecha:** Noviembre 2025  
**Estado:** ARQUITECTURA BASE INAMOVIBLE  
**Empresa:** NIELAY IA (PagoSiniestros.com)

---

## 📊 ANÁLISIS DEL ESTADO ACTUAL

### ✅ LO QUE YA EXISTE (OPERATIVO)

**Base de Datos PostgreSQL 16:**
- ✅ 11 schemas enterprise-grade
- ✅ 43+ tablas con relaciones complejas
- ✅ Row Level Security (RLS) activo
- ✅ Particionado (processing_jobs por trimestre)
- ✅ pgvector para embeddings
- ✅ Multi-tenant nativo con tenant_id

**Schemas Operativos:**
1. `newenia_global_core` - Sistema central
2. `newenia_ai_universal` - Orquestación IA
3. `newenia_document_processing` - Procesamiento docs
4. `newenia_automation_engine` - Motor automatización
5. `newenia_vector_storage` - RAG y embeddings
6. `newenia_revenue_core` - Facturación y monetización
7. `newenia_connectors` - Integraciones externas
8. `newenia_analytics_global` - BI y analíticas
9. `newenia_security_audit` - Seguridad y compliance
10. `newenia_client_success` - Gestión clientes
11. `public` - Laravel core (users, migrations, etc.)

**Stack Tecnológico:**
- ✅ Laravel 11 instalado
- ✅ Filament 3 instalado
- ✅ PHP 8.2 + PHP-FPM
- ✅ PostgreSQL 16 con pgvector
- ✅ Servidor Contabo VPS (vmi2780254)
- ✅ Docker listo para deployment
- ✅ Nginx + Apache (reverse proxy)

### ⚠️ LO QUE FALTA (POR CONSTRUIR)

**Capa Aplicación:**
- ⏳ Models Laravel mapeando a schemas existentes
- ⏳ Filament Resources para administración
- ⏳ Middleware SetTenantContext (CRÍTICO)
- ⏳ Trait TenantScoped para isolation
- ⏳ API REST endpoints
- ⏳ Tests automatizados (>85% coverage)
- ⏳ CI/CD pipeline
- ⏳ Documentación técnica completa

**Lógica de Negocio:**
- ⏳ State Machine (PLAN→RETRIEVE→GENERATE→VERIFY→CONSENSUS→DELIVER→LOG)
- ⏳ Consensus Multi-Provider (OpenAI + Claude + Ollama)
- ⏳ Reinforcement Feedback Loop (RFL)
- ⏳ Meta-Learning Layer
- ⏳ Cognitive Performance Framework (CPF)
- ⏳ Telemetría y observabilidad (Prometheus + Grafana)

---

## 🏛️ ESTRUCTURA DEFINITIVA

### 📂 DIRECTORIO ROOT

```
/var/www/nielay-erp/
├── app/                          # Aplicación Laravel
│   ├── Console/                  # Comandos artisan
│   ├── Exceptions/               # Manejadores de excepciones
│   ├── Filament/                 # Panel administración
│   │   ├── Resources/            # CRUD resources por módulo
│   │   ├── Pages/                # Páginas personalizadas
│   │   ├── Widgets/              # Dashboards y widgets
│   │   └── Clusters/             # Agrupación de resources
│   ├── Http/
│   │   ├── Controllers/          # Controllers REST API
│   │   │   ├── Api/              # API v1, v2
│   │   │   └── Web/              # Web controllers
│   │   ├── Middleware/           # Middleware custom
│   │   │   ├── SetTenantContext.php    # ⭐ CRÍTICO
│   │   │   ├── VerifyTenantAccess.php
│   │   │   └── AuditLogger.php
│   │   └── Requests/             # Form requests validación
│   ├── Models/                   # Eloquent Models
│   │   ├── Core/                 # M1: Core System
│   │   │   ├── Tenant.php
│   │   │   ├── User.php
│   │   │   ├── Role.php
│   │   │   └── Client.php
│   │   ├── AI/                   # M2: AI Orchestration
│   │   │   ├── ProcessingJob.php
│   │   │   ├── AIProvider.php
│   │   │   ├── Consensus.php
│   │   │   └── PolicyByIntent.php
│   │   ├── Document/             # M3: Document Processing
│   │   │   ├── Document.php
│   │   │   ├── DocumentChunk.php
│   │   │   └── ExtractionRule.php
│   │   ├── Automation/           # M4: Automation Engine
│   │   │   ├── AutomationTemplate.php
│   │   │   ├── WorkflowExecution.php
│   │   │   └── TaskQueue.php
│   │   ├── Vector/               # M5: Vector & RAG
│   │   │   ├── UniversalEmbedding.php
│   │   │   ├── VectorSearch.php
│   │   │   └── RAGContext.php
│   │   ├── Revenue/              # M6: Revenue & Billing
│   │   │   ├── Subscription.php
│   │   │   ├── Invoice.php
│   │   │   ├── UsageCounter.php
│   │   │   └── PricingTier.php
│   │   ├── Connector/            # M7: Connectors
│   │   │   ├── ExternalSystem.php
│   │   │   ├── APICredential.php
│   │   │   └── SyncLog.php
│   │   ├── Analytics/            # M8: Analytics & BI
│   │   │   ├── Metric.php
│   │   │   ├── Report.php
│   │   │   └── Dashboard.php
│   │   ├── Security/             # M9: Security
│   │   │   ├── AuditLog.php
│   │   │   ├── AuditRequest.php
│   │   │   └── SecurityIncident.php
│   │   └── ClientSuccess/        # M10: Client Success
│   │       ├── SupportTicket.php
│   │       ├── HealthScore.php
│   │       └── SuccessMetric.php
│   ├── Policies/                 # Authorization policies
│   ├── Providers/                # Service providers
│   ├── Services/                 # Business logic services
│   │   ├── AI/
│   │   │   ├── StateMachineService.php       # ⭐ State Machine
│   │   │   ├── ConsensusService.php          # Multi-provider
│   │   │   ├── MemoryRouterService.php       # 4D Memory
│   │   │   ├── RFLService.php                # Aprendizaje
│   │   │   └── MetaLearningService.php       # Meta-Learning
│   │   ├── Core/
│   │   │   ├── TenantService.php
│   │   │   ├── AuthService.php
│   │   │   └── PermissionService.php
│   │   ├── Document/
│   │   │   ├── OCRService.php
│   │   │   ├── ChunkingService.php
│   │   │   └── PIIMaskingService.php
│   │   ├── Vector/
│   │   │   ├── EmbeddingService.php
│   │   │   ├── HybridSearchService.php
│   │   │   └── RerankerService.php
│   │   └── Telemetry/
│   │       ├── MetricsCollector.php
│   │       └── PrometheusExporter.php
│   └── Traits/                   # Traits reutilizables
│       ├── TenantScoped.php      # ⭐ CRÍTICO
│       ├── HasMetadata.php
│       ├── Auditable.php
│       └── HasUuid.php
├── bootstrap/                    # Archivos bootstrap Laravel
├── config/                       # Configuraciones
│   ├── database.php
│   ├── filament.php
│   ├── services.php              # API keys, providers
│   └── nielay.php                # Configuración NIELAY custom
├── database/
│   ├── factories/                # Factories para testing
│   ├── migrations/               # Migraciones Laravel
│   │   ├── 2014_10_12_000000_create_users_table.php
│   │   ├── 2025_01_01_000001_add_tenant_fields_to_users_table.php
│   │   └── [NUEVAS MIGRACIONES AQUÍ]
│   └── seeders/                  # Seeders
│       ├── DatabaseSeeder.php
│       ├── RoleSeeder.php
│       └── TenantSeeder.php
├── docs/                         # 📚 DOCUMENTACIÓN VIVA
│   ├── global/
│   │   ├── manifesto_cognitivo.md
│   │   ├── principios_diseno.md
│   │   └── etica_operativa.md
│   ├── architecture/
│   │   ├── state_machine_spec.md
│   │   ├── modelo_memorias_4d.md
│   │   ├── embeddings_strategy.md
│   │   └── database_schemas.md
│   ├── modules/                  # Docs por módulo M1-M11
│   │   ├── M1_core_system.md
│   │   ├── M2_ai_orchestration.md
│   │   ├── M3_document_processing.md
│   │   ├── M4_automation_engine.md
│   │   ├── M5_vector_rag.md
│   │   ├── M6_revenue_billing.md
│   │   ├── M7_connectors.md
│   │   ├── M8_analytics_bi.md
│   │   ├── M9_security.md
│   │   ├── M10_client_success.md
│   │   └── M11_admin_panel.md
│   ├── governance/
│   │   ├── cpf_framework.md     # Cognitive Performance
│   │   └── tasks/                # Tareas técnicas
│   │       ├── G3-EMB-TASKS.md
│   │       └── G4-RFL-TASKS.md
│   ├── infrastructure/
│   │   ├── deployment_guide.md
│   │   ├── docker_setup.md
│   │   └── monitoring_setup.md
│   └── api/
│       ├── openapi.json
│       └── endpoints.md
├── public/                       # Assets públicos
├── resources/
│   ├── views/                    # Blade templates
│   └── css/                      # Estilos CSS
├── routes/
│   ├── web.php                   # Rutas web
│   ├── api.php                   # Rutas API
│   └── console.php               # Comandos artisan
├── storage/
│   ├── app/                      # Archivos aplicación
│   ├── framework/                # Cache, sessions
│   ├── logs/                     # Logs aplicación
│   └── backups/                  # Backups automáticos
├── tests/
│   ├── Feature/                  # Tests de integración
│   │   ├── Auth/
│   │   ├── Tenant/
│   │   │   └── TenantResourceTest.php
│   │   └── API/
│   │       ├── AIOrchestrationTest.php
│   │       ├── DocumentProcessingTest.php
│   │       └── VectorSearchTest.php
│   └── Unit/                     # Tests unitarios
│       ├── Models/
│       │   └── TenantTest.php
│       ├── Services/
│       │   ├── StateMachineTest.php
│       │   ├── ConsensusTest.php
│       │   └── RFLTest.php
│       └── Traits/
│           └── TenantScopedTest.php
├── .env                          # Variables entorno (NO en git)
├── .env.example                  # Template .env
├── .gitignore
├── artisan                       # CLI Laravel
├── composer.json                 # Dependencias PHP
├── composer.lock
├── docker-compose.yml            # Docker setup
├── Dockerfile
├── phpunit.xml                   # Configuración tests
├── README.md                     # Documentación proyecto
└── ESTADO_PROYECTO.md            # ⭐ ESTADO ACTUAL (CRÍTICO)
```

---

## 🎯 MÓDULOS Y MAPEO A SCHEMAS

### M1: CORE SYSTEM (Prioridad CRÍTICA ⭐⭐⭐)

**Schema:** `newenia_global_core` + `public`  
**Responsabilidad:** Fundación multi-tenant, auth, permisos

**Componentes:**

```
app/Models/Core/
├── Tenant.php              → newenia_global_core.global_clients
├── User.php                → public.users (con tenant_id, role)
├── Role.php                → newenia_global_core.user_roles
├── Permission.php          → newenia_global_core.permissions
└── TenantMembership.php    → newenia_global_core.tenant_memberships

app/Filament/Resources/
├── TenantResource.php
├── UserResource.php
└── RoleResource.php

app/Http/Middleware/
├── SetTenantContext.php    ⭐ CRÍTICO
└── VerifyTenantAccess.php

app/Traits/
└── TenantScoped.php        ⭐ CRÍTICO

app/Services/Core/
├── TenantService.php
├── AuthService.php
└── PermissionService.php
```

**Características Clave:**
- Multi-tenancy con RLS a nivel BD
- MFA (Multi-Factor Authentication)
- RBAC (Role-Based Access Control)
- Audit logging completo
- Session management con tenant_id

---

### M2: AI ORCHESTRATION (Prioridad CRÍTICA ⭐⭐⭐)

**Schema:** `newenia_ai_universal`  
**Responsabilidad:** Consenso multi-provider, state machine, RFL

**Componentes:**

```
app/Models/AI/
├── ProcessingJob.php       → newenia_ai_universal.processing_jobs
├── AIProvider.php          → newenia_ai_universal.ai_providers
├── Consensus.php           → newenia_ai_universal.consensus_log
├── PolicyByIntent.php      → newenia_ai_universal.policies_by_intent
└── LearningEvent.php       → newenia_ai_universal.learning_events

app/Services/AI/
├── StateMachineService.php      # PLAN→RETRIEVE→GENERATE→VERIFY→CONSENSUS→DELIVER→LOG
├── ConsensusService.php         # Multi-provider (OpenAI + Claude + Ollama)
├── MemoryRouterService.php      # Memoria 4D (personal, factual, estructurada, orquestación)
├── RFLService.php               # Reinforcement Feedback Loop
└── MetaLearningService.php      # Ajuste automático de políticas

app/Jobs/
├── ProcessAIJobStateMachine.php
├── CollectConsensusJob.php
└── UpdatePoliciesJob.php
```

**Arquitectura Cognitiva - State Machine:**

```
PLAN
  ↓ (intent detection, memory routing, provider selection)
RETRIEVE
  ↓ (vector search + TF-IDF, context building)
GENERATE
  ↓ (LLM inference con contexto)
VERIFY
  ↓ (verificación factual, PII check, citas)
CONSENSUS
  ↓ (multi-provider voting si es crítico)
DELIVER
  ↓ (respuesta al cliente con métricas)
LOG
  ↓ (audit, telemetría, learning signals)
```

---

### M3: DOCUMENT PROCESSING (Prioridad ALTA ⭐⭐)

**Schema:** `newenia_document_processing`  
**Responsabilidad:** OCR, chunking, extracción, PII masking

**Componentes:**

```
app/Models/Document/
├── Document.php            → newenia_document_processing.documents
├── DocumentChunk.php       → newenia_document_processing.document_chunks
├── ExtractionRule.php      → newenia_document_processing.extraction_rules
└── PIIMask.php             → newenia_document_processing.pii_detections

app/Services/Document/
├── OCRService.php          # Tesseract/Cloud Vision API
├── ChunkingService.php     # Semantic chunking 300-500 tokens
├── PIIMaskingService.php   # Detección y masking PII
└── MetadataExtractor.php   # Extracción metadata automática
```

---

### M4: AUTOMATION ENGINE (Prioridad ALTA ⭐⭐)

**Schema:** `newenia_automation_engine`  
**Responsabilidad:** Workflows, templates, task queue

**Componentes:**

```
app/Models/Automation/
├── AutomationTemplate.php  → newenia_automation_engine.automation_templates
├── WorkflowExecution.php   → newenia_automation_engine.workflow_executions
└── TaskQueue.php           → newenia_automation_engine.task_queue

app/Services/Automation/
├── WorkflowEngine.php
├── TemplateRenderer.php
└── QueueManager.php
```

---

### M5: VECTOR & RAG (Prioridad CRÍTICA ⭐⭐⭐)

**Schema:** `newenia_vector_storage`  
**Responsabilidad:** Embeddings, búsqueda híbrida, RAG pipeline

**Componentes:**

```
app/Models/Vector/
├── UniversalEmbedding.php  → newenia_vector_storage.universal_embeddings
├── VectorSearch.php
└── RAGContext.php

app/Services/Vector/
├── EmbeddingService.php        # OpenAI + Ollama embeddings
├── HybridSearchService.php     # Vector + TF-IDF (pg_trgm)
├── RerankerService.php         # bge-reranker local
└── RAGPipeline.php             # Ingesta → Embed → Index → Retrieve
```

**Estrategia Embeddings:**
- Producción: `text-embedding-3-small` (1536D, bajo costo)
- Batch/Local: `e5-large-v2` o `bge-m3` (ASUS 5070 Ti)
- Crítico: `text-embedding-3-large` (3072D) + reranker local

**Búsqueda Híbrida:**
- Vector search (pgvector IVFFlat/HNSW)
- TF-IDF (pg_trgm)
- Fusión: RRF (Reciprocal Rank Fusion) o Weighted Average
- Alpha: 0.7 vector + 0.3 texto (ajustable por RFL)

---

### M6: REVENUE & BILLING (Prioridad ALTA ⭐⭐)

**Schema:** `newenia_revenue_core`  
**Responsabilidad:** Facturación, subscripciones, usage tracking

**Componentes:**

```
app/Models/Revenue/
├── Subscription.php        → newenia_revenue_core.subscriptions
├── Invoice.php             → newenia_revenue_core.invoices
├── UsageCounter.php        → newenia_revenue_core.usage_counters
└── PricingTier.php         → newenia_revenue_core.pricing_tiers

app/Services/Revenue/
├── BillingService.php
├── UsageTracker.php
└── InvoiceGenerator.php
```

---

### M7: CONNECTORS (Prioridad MEDIA ⭐)

**Schema:** `newenia_connectors`  
**Responsabilidad:** Integraciones externas (Gmail, Drive, Slack, etc.)

---

### M8: ANALYTICS & BI (Prioridad ALTA ⭐⭐)

**Schema:** `newenia_analytics_global`  
**Responsabilidad:** Métricas, dashboards, reportes

---

### M9: SECURITY & COMPLIANCE (Prioridad CRÍTICA ⭐⭐⭐)

**Schema:** `newenia_security_audit`  
**Responsabilidad:** Audit logs, seguridad, compliance

---

### M10: CLIENT SUCCESS (Prioridad MEDIA ⭐)

**Schema:** `newenia_client_success`  
**Responsabilidad:** Health scores, tickets, métricas cliente

---

### M11: ADMIN PANEL (Prioridad CRÍTICA ⭐⭐⭐)

**Framework:** Filament 3  
**Responsabilidad:** UI administrativa para todos los módulos

---

## 🔧 COMPONENTES CRÍTICOS OBLIGATORIOS

### 1. SetTenantContext Middleware

```php
// app/Http/Middleware/SetTenantContext.php
namespace App\Http\Middleware;

use Illuminate\Support\Facades\DB;
use Closure;

class SetTenantContext
{
    public function handle($request, Closure $next)
    {
        $tenantId = auth()->user()->current_tenant_id ?? 0;
        
        // Establecer contexto en PostgreSQL para RLS
        DB::statement(
            "SELECT newenia_global_core.set_tenant_id(?)", 
            [$tenantId]
        );
        
        // Registrar en sesión para Global Scope
        session(['tenant_id' => $tenantId]);
        
        return $next($request);
    }
}
```

**Registrar en `app/Http/Kernel.php`:**

```php
protected $middlewareGroups = [
    'web' => [
        // ... otros middlewares
        \App\Http\Middleware\SetTenantContext::class, // ⭐ CRÍTICO
    ],
];
```

---

### 2. TenantScoped Trait

```php
// app/Traits/TenantScoped.php
namespace App\Traits;

use Illuminate\Database\Eloquent\Builder;

trait TenantScoped
{
    protected static function bootTenantScoped()
    {
        static::addGlobalScope('tenant', function (Builder $query) {
            $tenantId = session('tenant_id', 0);
            
            if ($query->getQuery()->wheres) {
                // Si ya hay WHERE, agregar AND
                $query->where('tenant_id', $tenantId);
            } else {
                // Primer WHERE
                $query->where('tenant_id', $tenantId);
            }
        });
    }
    
    public static function withoutTenantScope()
    {
        return static::withoutGlobalScope('tenant');
    }
}
```

**Uso en Models:**

```php
namespace App\Models\Core;

use App\Traits\TenantScoped;
use Illuminate\Database\Eloquent\Model;

class Client extends Model
{
    use TenantScoped; // ⭐ Aislamiento automático por tenant
    
    protected $table = 'newenia_global_core.global_clients';
    
    protected $primaryKey = 'id_client';
    
    protected $fillable = [
        'company_name',
        'business_sector',
        'tenant_id',
        // ...
    ];
}
```

---

### 3. Reglas tenant_id OBLIGATORIAS

| Tipo de Registro | tenant_id | Ejemplo |
|------------------|-----------|---------|
| **Tenants raíz (sistema)** | `0` | Empresas cliente de NIELAY |
| **Clientes finales** | `(tenant actual)` | Clientes del tenant |
| **Usuarios globales** | `0` o vía memberships | Usuarios multi-tenant |
| **Jobs, docs, vectores** | `(tenant actual)` | Datos del tenant |
| **Audit logs** | `(tenant actual)` | Trazabilidad por tenant |
| **AI consensus** | `(tenant actual)` | Decisiones IA por tenant |

**🚨 CRÍTICO:** NUNCA derivar `tenant_id` de otros campos. SIEMPRE desde contexto.

---

## 📊 ARQUITECTURA COGNITIVA - LAS 5 DIMENSIONES

### Dimensión 1: COMPRENDE (Context Engineering)

**Objetivo:** Extraer significado y relevancia contextual  
**Implementación:** Memory Router + State Machine (PLAN)

**Componentes:**
- Intent Detection (classifier)
- Memory Routing (4D: personal, factual, estructurada, orquestación)
- Context Building (priorización de tokens relevantes)

**Métricas:**
- `memory_hits_total{type}`
- `%tokens_útiles` (Context Pruning Factor)
- Latencia p95 fase PLAN

---

### Dimensión 2: APRENDE (Reinforcement Feedback Loop)

**Objetivo:** Analizar errores y éxitos para ajustar políticas  
**Implementación:** RFL Engine

**Componentes:**
- Signal Collection (verify.fail, costo, latencia, feedback humano)
- Action Execution (cambio proveedor, temperatura, top-k)
- Outcome Tracking (delta CKPI - Cognitive KPI)

**Métricas:**
- `rfl_actions_total{signal,action}`
- `delta_ckpi` (mejora/empeoramiento)
- Tasa de mejoras automáticas/semana

---

### Dimensión 3: RECUERDA (Multi-Memory 4D)

**Objetivo:** Usar memorias contextuales efectivamente  
**Implementación:** Memory Router + pgvector

**4 Tipos de Memoria:**

1. **Personal:** Preferencias usuario, historial interacciones
2. **Factual:** Conocimiento verificado con citas
3. **Estructurada:** Datos tabulares, taxonomías
4. **Orquestación:** Decisiones pasadas IA, políticas

**Métricas:**
- `memory_size_bytes{type}`
- `memory_access_latency_ms`
- Hit rate por tipo de memoria

---

### Dimensión 4: ACTÚA (State Machine + Automation)

**Objetivo:** Ejecutar tareas con precisión y evidencia  
**Implementación:** State Machine PLAN→LOG + Automation Engine

**Estados del State Machine:**

```
PLAN → RETRIEVE → GENERATE → VERIFY → CONSENSUS → DELIVER → LOG
```

**Métricas:**
- `jobs_in_queue{stage}`
- `latency_p95_ms{stage}`
- `cost_usd_total{provider}`
- `verify_fail_rate`

---

### Dimensión 5: MEJORA (Meta-Learning Layer)

**Objetivo:** Evaluar rendimiento y aplicar meta-aprendizaje  
**Implementación:** Meta-Learning Layer + CPF (Cognitive Performance Framework)

**Componentes:**
- Policy Promotion (RFL → policies_by_intent)
- Performance Analysis (IC, costo, latencia, precisión)
- Auto-Tuning (alpha, k, temperatura por intent)

**Métricas:**
- `ic_understood_total / ic_attempts_total` (Intención Comprendida)
- `policy_updates_auto_total`
- Gate Nivel-4: IC +10% O Costo -15% sin perder precisión

---

## 🔬 COGNITIVE PERFORMANCE FRAMEWORK (CPF)

### Métricas Clave (Balanced Scorecard Cognitivo)

| Métrica | Target | Fórmula |
|---------|--------|---------|
| **IC (Intención Comprendida)** | >95% | ic_understood / ic_attempts |
| **Precisión Factual** | >98% | verify_pass / verify_total |
| **Hit Rate Memoria** | >70% | memory_hits / memory_queries |
| **Cost per Intent** | <$0.05 | cost_usd / jobs_completed |
| **Latencia p95** | <400ms | histogram p95 por stage |
| **Consensus Accuracy** | >99% | consensus_correct / consensus_total |

### Dashboard Grafana (Cognitive Overview)

**Paneles Obligatorios:**

1. **Comprensión:**
   - IC rate (%) por intent
   - Memory hits (%) por tipo
   - Context Pruning Factor (%)

2. **Aprendizaje:**
   - RFL actions/semana
   - Delta CKPI por acción
   - Policy updates automáticas

3. **Memoria:**
   - Tamaño memoria (MB) por tipo
   - Latencia acceso (ms)
   - Hit rate histórico

4. **Acción:**
   - Jobs en cola por stage
   - Latencia p95 (ms) por stage
   - Costo (USD) por provider

5. **Mejora:**
   - IC trend (7 días, 30 días)
   - Costo trend (7 días, 30 días)
   - Gate Level actual (1-5)

---

## 🧪 TESTING STRATEGY

### Cobertura Mínima: >85%

**Pirámide de Testing:**

```
      ╱╲
     ╱E2E╲         10% - Tests end-to-end (Filament UI)
    ╱─────╲
   ╱INTEGR╲        30% - Tests integración (API, Services)
  ╱────────╲
 ╱  UNIT   ╲      60% - Tests unitarios (Models, Traits, Helpers)
╱───────────╲
```

### Tests Obligatorios

**Unit Tests:**

```
tests/Unit/
├── Models/
│   ├── TenantTest.php                    # ✅ 24 tests
│   ├── UserTest.php
│   └── ProcessingJobTest.php
├── Services/
│   ├── StateMachineTest.php              # State transitions
│   ├── ConsensusTest.php                 # Multi-provider
│   ├── RFLTest.php                       # Learning signals
│   └── MemoryRouterTest.php              # 4D memory
└── Traits/
    └── TenantScopedTest.php              # Isolation
```

**Feature Tests:**

```
tests/Feature/
├── Auth/
│   ├── RegistrationTest.php
│   ├── AuthenticationTest.php
│   └── MFATest.php
├── Tenant/
│   └── TenantResourceTest.php            # ✅ 17 tests
└── API/
    ├── AIOrchestrationTest.php           # State machine E2E
    ├── VectorSearchTest.php              # Hybrid search
    └── ConsensusTest.php                 # Multi-provider consensus
```

**Definition of Done (DoD):**

```
☑️ Tests escritos con >85% coverage
☑️ Tests pasan en CI (phpunit + pest)
☑️ Documentación actualizada en /docs
☑️ Métricas expuestas en /metrics
☑️ PR reviewed y aprobado
☑️ Canary deployment exitoso (24-48h)
```

---

## 📈 TELEMETRÍA Y OBSERVABILIDAD

### Prometheus Metrics Endpoint

**Ubicación:** `GET /metrics`

**Métricas Obligatorias:**

```
# Comprensión
ic_understood_total{intent,tenant_id}
ic_attempts_total{intent,tenant_id}
memory_hits_total{type,tenant_id}
memory_queries_total{type,tenant_id}
context_pruning_factor{tenant_id}

# Aprendizaje
rfl_actions_total{signal,action,tenant_id}
delta_ckpi{action,tenant_id}
policy_updates_auto_total{tenant_id}

# Memoria
memory_size_bytes{type,tenant_id}
memory_access_latency_ms{type,tenant_id}

# Acción
jobs_in_queue{stage,tenant_id}
latency_p95_ms{stage,tenant_id}
cost_usd_total{provider,tenant_id}
verify_fail_rate{tenant_id}

# Mejora
gate_level{tenant_id}
ic_trend_7d{tenant_id}
cost_trend_7d{tenant_id}
```

### Grafana Dashboards

**Dashboard Principal:** "Cognitive Overview - NIELAY"

**Alertas Críticas:**

1. **Latencia p95 > 1.5s** (5m) → Slack #alerts
2. **Backlog GENERATE > 20** (5m) → Slack #alerts
3. **IC < 90%** (1h) → Email tech lead
4. **Verify fail > 5%** (30m) → Email + Slack
5. **Cost spike > 20%** (1d) → Email finance

---

## 🚀 CI/CD PIPELINE

### GitHub Actions Workflow

**Archivo:** `.github/workflows/ci.yml`

**Stages:**

```yaml
stages:
  - lint       # PHP CS Fixer, PHPStan
  - test       # PHPUnit + Pest
  - build      # Docker image
  - deploy     # Staging → Canary → Prod
  - verify     # Health check
```

**Deployment Strategy:**

```
Feature Branch
     ↓ (PR + CI pass)
Development Branch
     ↓ (Deploy staging)
Staging Environment
     ↓ (Manual approval)
Canary Deployment (10% traffic, 24-48h)
     ↓ (Metrics gate: p95<400ms, IC>95%, cost OK)
Production (100% traffic)
```

**Metrics Gate (Auto-rollback si falla):**

```
✓ p95 latency <= 400ms
✓ IC >= 95%
✓ Precision >= 98%
✓ Cost increase <= 10%
```

---

## 📦 DEPLOYMENT ARCHITECTURE

### Docker Compose Stack

```yaml
services:
  nginx:
    image: nginx:alpine
    ports: ["80:80", "443:443"]
    
  php-fpm:
    build: .
    environment:
      - APP_ENV=production
      
  postgres:
    image: postgres:16
    volumes:
      - pgdata:/var/lib/postgresql/data
      
  redis:
    image: redis:alpine
    
  prometheus:
    image: prom/prometheus
    
  grafana:
    image: grafana/grafana
```

### Infrastructure

**Servidor:** Contabo VPS (vmi2780254)  
**OS:** Ubuntu 24  
**Web Server:** Nginx (reverse proxy) + Apache  
**PHP:** PHP-FPM 8.2  
**Database:** PostgreSQL 16 con pgvector  
**Cache:** Redis  
**Queue:** Redis + Horizon  
**Monitoring:** Prometheus + Grafana

---

## 🎯 PLAN DE IMPLEMENTACIÓN

### FASE 1: Foundation (Semana 1) ⭐⭐⭐

**Prioridad:** CRÍTICA  
**Objetivo:** Base sólida multi-tenant + auth

**Tareas:**

1. ✅ Crear `SetTenantContext` middleware
2. ✅ Crear `TenantScoped` trait
3. ✅ Model Tenant.php mapeando global_clients
4. ✅ TenantResource en Filament (CRUD completo)
5. ✅ UserResource con MFA
6. ✅ RoleResource + Permissions
7. ✅ Tests >85% coverage
8. ✅ Documentación en /docs/modules/M1_core_system.md

**Entregables:**

- Panel Filament admin funcional
- Auth completo con MFA
- Multi-tenancy activo con RLS
- Tests pasando (>45/52)

---

### FASE 2: AI Orchestration (Semana 2) ⭐⭐⭐

**Prioridad:** CRÍTICA  
**Objetivo:** State Machine + Consensus activos

**Tareas:**

1. State Machine Service (PLAN→LOG)
2. Consensus Service (OpenAI + Claude + Ollama)
3. Memory Router (4D memory)
4. ProcessingJob Model + Resource
5. API endpoints `/ai/orchestrate`
6. Tests state machine completos
7. Métricas Prometheus

**Entregables:**

- State Machine funcional
- Consensus multi-provider operativo
- Dashboard "AI Orchestration" en Grafana
- API documentada en OpenAPI

---

### FASE 3: Vector & RAG (Semana 3) ⭐⭐⭐

**Prioridad:** CRÍTICA  
**Objetivo:** Búsqueda híbrida + RAG pipeline

**Tareas:**

1. Embedding Service (OpenAI + local)
2. Hybrid Search (pgvector + pg_trgm)
3. RAG Pipeline (ingesta → embed → retrieve)
4. PII Masking Service
5. Reranker local (bge-reranker)
6. API endpoint `/search/hybrid`
7. Tests >70% hit rate

**Entregables:**

- Búsqueda híbrida operativa
- RAG con citas y verificación factual
- Dashboard "Vector Search" en Grafana
- Documentación embeddings strategy

---

### FASE 4: RFL + Meta-Learning (Semana 4) ⭐⭐

**Prioridad:** ALTA  
**Objetivo:** Aprendizaje automático activo

**Tareas:**

1. RFL Engine (signal → action → outcome)
2. Meta-Learning Layer (policy promotion)
3. Job nocturno auto-tuning
4. Dashboard CPF en Grafana
5. Tests mejoras reales en sandbox
6. Documentación RFL + Meta-Learning

**Entregables:**

- ≥2 mejoras automáticas/semana
- Delta CKPI visible en dashboard
- Gate Nivel-4 logrado
- Sistema auto-mejorable operativo

---

### FASE 5: Revenue + Analytics (Semana 5) ⭐⭐

**Prioridad:** ALTA (Monetización)  
**Objetivo:** Billing + BI operativos

---

### FASE 6: Connectors + Client Success (Semana 6) ⭐

**Prioridad:** MEDIA  
**Objetivo:** Integraciones + soporte

---

## 🔐 SECURITY & COMPLIANCE

### Seguridad Multi-Capa

**1. Network Level:**
- Nginx TLS 1.3
- Bloqueo .env, .git
- Rate limiting por IP
- DDoS protection (Cloudflare)

**2. Application Level:**
- RLS en PostgreSQL (tenant_id)
- CSRF tokens
- XSS protection
- SQL injection prevention (Eloquent)
- Input validation (Form Requests)

**3. Data Level:**
- Encryption at rest (PostgreSQL)
- Encryption in transit (TLS)
- PII masking en documentos
- Audit logging completo

**4. Authentication:**
- MFA obligatorio para admins
- Password hashing (bcrypt)
- Session timeout
- Token rotation

**5. Authorization:**
- RBAC granular por tenant
- Policies Laravel
- Gates personalizados
- API key rotation

---

## 📝 DOCUMENTACIÓN VIVA

### Principio: "La documentación es código"

**Estructura en `/docs`:**

```
docs/
├── global/                    # Filosofía y principios
├── architecture/              # Arquitectura técnica
├── modules/                   # Docs por módulo M1-M11
├── governance/                # CPF, tareas, roadmap
├── infrastructure/            # Deployment, monitoring
└── api/                       # OpenAPI spec, endpoints
```

**Reglas Obligatorias:**

1. ✅ Cada PR debe actualizar /docs
2. ✅ Sin doc actualizada = PR rechazado
3. ✅ CHANGELOG técnico + cognitivo en releases
4. ✅ Reporte CPF mensual con IIR

---

## 🎓 GLOSARIO TÉCNICO

| Término | Definición |
|---------|-----------|
| **RLS** | Row Level Security - Seguridad a nivel fila en PostgreSQL |
| **RFL** | Reinforcement Feedback Loop - Ciclo aprendizaje reforzado |
| **CPF** | Cognitive Performance Framework - BSC cognitivo |
| **IC** | Intención Comprendida - Métrica comprensión |
| **CKPI** | Cognitive Key Performance Indicator |
| **IIR** | Índice Inteligencia Real - Métrica global |
| **State Machine** | PLAN→RETRIEVE→GENERATE→VERIFY→CONSENSUS→DELIVER→LOG |
| **Consensus** | Votación multi-provider para decisiones críticas |
| **Memory 4D** | Personal, Factual, Estructurada, Orquestación |
| **Context Engineering** | Curación contexto priorizando tokens señal |
| **RAG** | Retrieval-Augmented Generation |
| **PII** | Personally Identifiable Information |
| **Hybrid Search** | Vector + TF-IDF fusionados |
| **RRF** | Reciprocal Rank Fusion |

---

## ✅ CHECKLIST CRÍTICO PRE-DESARROLLO

**Antes de empezar CUALQUIER código:**

### Infraestructura

- [ ] Acceso SSH a vmi2780254 confirmado
- [ ] PostgreSQL 16 con pgvector instalado
- [ ] Credenciales BD configuradas en .env
- [ ] PHP 8.2 + PHP-FPM funcionando
- [ ] Composer instalado
- [ ] Docker + Docker Compose instalados
- [ ] Git configurado con SSH keys

### Laravel Setup

- [ ] Laravel 11 instalado
- [ ] Filament 3 instalado
- [ ] .env configurado correctamente
- [ ] `php artisan key:generate` ejecutado
- [ ] Database connection verificada
- [ ] Migraciones existentes revisadas

### Archivos Críticos

- [ ] `SetTenantContext.php` middleware creado
- [ ] `TenantScoped.php` trait creado
- [ ] Middleware registrado en Kernel.php
- [ ] ESTADO_PROYECTO.md creado y actualizado

### Testing

- [ ] PHPUnit configurado
- [ ] Pest instalado (opcional)
- [ ] Tests existentes pasando
- [ ] Coverage >85% como objetivo

### Git Workflow

- [ ] Repositorio GitHub creado
- [ ] Branches: main, development creados
- [ ] PR template configurado
- [ ] .gitignore configurado correctamente

### Documentación

- [ ] /docs estructura creada
- [ ] Manifesto Cognitivo presente
- [ ] Architecture docs inicializados
- [ ] README.md completo

---

## 🚨 PROHIBICIONES ABSOLUTAS

### ❌ NUNCA HACER:

1. Modificar schemas BD sin aprobación explícita
2. Derivar `tenant_id` de otros campos
3. Omitir middleware `SetTenantContext`
4. Skip tests (<85% coverage requerido)
5. Delete sin validar dependencias
6. Hardcodear valores tenant/cliente
7. Exponer datos cross-tenant
8. Commit código sin lint/format
9. Merge sin PR review
10. Deploy sin tests pasando
11. Crear migraciones sin `Schema::hasColumn()`
12. Asumir que algo NO existe sin verificar
13. Ejecutar comandos sin backup previo
14. Modificar código funcionando sin razón
15. Proponer "empezar de cero"

---

## 🏆 OBJETIVOS MEDIBLES

### Técnicos (6 meses)

- ✅ 11 módulos implementados y operativos
- ✅ >85% test coverage en toda la aplicación
- ✅ Latencia p95 <400ms en todos los endpoints
- ✅ IC >95% (Intención Comprendida)
- ✅ Precisión factual >98%
- ✅ ≥2 mejoras automáticas RFL/semana
- ✅ Gate Nivel-4 logrado
- ✅ Zero downtime deployments
- ✅ Documentación 100% actualizada

### Negocio (12 meses)

- 🎯 293 clientes PagoSiniestros migrados
- 🎯 TePresupuesto.com lanzado
- 🎯  3 clientes enterprise (>$10K MRR cada uno)
- 🎯 $300K ARR alcanzado
- 🎯 <5% churn rate
- 🎯 >110% Net Revenue Retention
- 🎯 Expansión Colombia iniciada

---

## 📋 RESUMEN EJECUTIVO

**NIELAY es una plataforma de IA cognitiva** que integra:

1. **Cerebro Operativo:** PostgreSQL 16 con 11 schemas, 43+ tablas
2. **Sistema Nervioso:** Laravel 11 + Filament 3
3. **Inteligencia:** Consensus multi-provider (OpenAI + Claude + Ollama)
4. **Aprendizaje:** RFL + Meta-Learning auto-mejorables
5. **Memoria:** 4D (personal, factual, estructurada, orquestación)
6. **Observabilidad:** Prometheus + Grafana con CPF

**La estructura es:**

- ✅ **Modular:** 11 módulos claramente separados
- ✅ **Escalable:** Multi-tenant nativo con RLS
- ✅ **Segura:** Security multi-capa desde BD hasta API
- ✅ **Testeable:** >85% coverage obligatorio
- ✅ **Auditable:** Logging completo + telemetría
- ✅ **Auto-mejorable:** RFL + Meta-Learning activos
- ✅ **Documentada:** Docs vivas sincronizadas con código

**Próximos pasos inmediatos:**

1. Crear `ESTADO_PROYECTO.md` con esta estructura
2. Implementar `SetTenantContext` + `TenantScoped`
3. Comenzar FASE 1 (M1: Core System)
4. Tests >85% desde día 1
5. Deploy continuo con gates de calidad

---

**FIN ESTRUCTURA DEFINITIVA**

Versión: 1.0  
Estado: ARQUITECTURA BASE APROBADA  
Nivel: SILICON VALLEY STANDARD  
Empresa: NIELAY IA  
Fecha: Noviembre 2025

🚀 **READY TO BUILD**
