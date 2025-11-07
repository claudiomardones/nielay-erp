# 🗄️ ESTADO REAL PROYECTO NIELAY ERP

**Última actualización:** 07 Noviembre 2025 20:30  
**Versión:** 3.0 - VERIFICADO EN SERVIDOR  
**Servidor:** vmi2780254.contaboserver.net (Contabo)

---

## 🚨 ESTE ES EL ESTADO 100% REAL

Verificado con comandos directos en PostgreSQL del servidor.  
**NO ES ASPIRACIONAL - ES LO QUE EXISTE AHORA.**

---

## 📊 BASE DE DATOS - ESTRUCTURA REAL

### **Base de Datos:** `newenia`
- **PostgreSQL:** 14.19
- **Owner:** `newenia`
- **Host:** 127.0.0.1
- **Port:** 5432

### **Extensiones Activas:**
- ✅ `pgcrypto` - Encriptación
- ✅ `pg_trgm` - Búsqueda full-text
- ✅ `vector` - pgvector para embeddings
- ✅ `pg_stat_statements` - Métricas de queries

### **Usuarios con Permisos:**
- `postgres` (superuser)
- `newenia` (owner)
- `app_runtime` (aplicación)
- `nielay_login` (auth)
- `app_nielay_portal` (portal)

### **Seguridad:**
- ✅ RLS (Row Level Security) activo en 7 schemas
- ✅ 20 políticas RLS configuradas
- ✅ Variable de contexto: `app.tenant_id`

---

## 📋 INVENTARIO COMPLETO (23 TABLAS, 8 SCHEMAS)

### **1. newenia_ai_universal (2 tablas)**
Proveedores IA y eventos de aprendizaje

```sql
- ai_providers_global              ← Configuración providers (OpenAI, Claude, Ollama)
- learning_events                  ← Eventos de aprendizaje del sistema
```

**Características:**
- RLS: ✅ 2 políticas
- Secuencias: 2
- Índices: 4

---

### **2. newenia_automation_engine (4 tablas)**
Motor de automatización (n8n, jobs, credenciales)

```sql
- automation_instances             ← Instancias de automatizaciones
- automation_templates             ← Templates reutilizables
- processing_jobs                  ← Jobs en proceso
- workflow_credentials             ← Credenciales para workflows
```

**Características:**
- RLS: ✅ 2 políticas
- Secuencias: 3
- Índices: 9

---

### **3. newenia_document_processing (2 tablas)**
Documentos y sectores OCR canonizados

```sql
- source_documents                 ← Documentos fuente
- sector_texts                     ← Textos por sector
```

**Características:**
- RLS: ✅ 2 políticas
- Secuencias: 2
- Índices: 6

---

### **4. newenia_global_core (2 tablas)**
Tenancy y usuarios centrales - **CRÍTICO**

```sql
- tenants                          ← Clientes (multi-tenant)
- users                            ← Usuarios del sistema
```

**Características:**
- RLS: ❌ Sin políticas (tablas core)
- Secuencias: 2
- Índices: 5

---

### **5. newenia_revenue_core (1 tabla)**
Métricas y contadores de uso

```sql
- usage_meter                      ← Medición de uso por tenant
```

**Características:**
- RLS: ✅ 2 políticas
- Secuencias: 1
- Índices: 2

---

### **6. newenia_security_audit (2 tablas)**
Auditoría de acciones y requests

```sql
- security_audit_trail             ← Trail completo de auditoría
- api_request_log                  ← Log de requests API
```

**Características:**
- RLS: ✅ 2 políticas
- Secuencias: 1
- Índices: 10

---

### **7. newenia_vector_storage (1 tabla)**
Embeddings vectoriales

```sql
- universal_embeddings             ← Vectores 1536D para RAG
```

**Características:**
- RLS: ✅ 2 políticas
- Secuencias: 1
- Índices: 4
- Extensión: pgvector activa

---

### **8. public (9 tablas)**
Infraestructura Laravel

```sql
- cache                            ← Cache Laravel
- cache_locks                      ← Locks de cache
- failed_jobs                      ← Jobs fallidos
- job_batches                      ← Batches de jobs
- jobs                             ← Queue de jobs
- migrations                       ← Control de migraciones
- password_reset_tokens            ← Tokens de reset password
- personal_access_tokens           ← API tokens
- sessions                         ← Sesiones de usuarios
```

**Características:**
- RLS: ❌ Sin políticas (infraestructura)
- Secuencias: 4
- Índices: 16

---

### **9. newenia_analytics_global (0 tablas)**
Schema reservado para métricas futuras

**Estado:** Vacío, preparado para expansión

---

## 📁 ESTADO LARAVEL (ACTUAL)

### **Ubicación:** `/var/www/nielay-erp`

### **Laravel:** 12.36.1
- PHP: 8.2.29
- Composer: 2.8.12
- Filament: v4.1.10
- Livewire: v3.6.4

### **Archivos Custom Existentes:**

```bash
app/Console/Commands/
├── CreateSuperAdmin.php           ← Crear super admin
├── MemoryRouteCommand.php         ← Memory Router (incompleto)
└── NielayAutoLogin.php            ← Auto-login testing

app/Services/
└── MemoryRouterService.php        ← Servicio Memory Router básico

app/Http/Controllers/Health/
└── AuditHealthController.php      ← Health check

app/Models/
└── User.php                       ← Laravel User default

app/Providers/Filament/
└── AdminPanelProvider.php         ← Filament admin panel
```

### **Migraciones Laravel:**
```bash
- 0001_01_01_000000_create_users_table.php
- 0001_01_01_000001_create_cache_table.php
- 0001_01_01_000002_create_jobs_table.php
```

**IMPORTANTE:** Estas migraciones son de Laravel, NO de newenia.  
Las tablas de newenia YA EXISTEN en la BD.

### **Tests Actuales:**
- Total: 4 tests
- Pasando: 3 tests
- Fallando: 1 test (MemoryRouteHttpTest - falta ruta 'login')

### **Rutas Definidas:**
```
GET  /admin              ← Dashboard Filament
GET  /admin/login        ← Login Filament
GET  /memory/route       ← Memory Router (con errores)
GET  /login-direct       ← Login directo
GET  /simple-login-form  ← Form login simple
```

---

## ⚠️ GAPS IDENTIFICADOS

### **1. Desconexión Laravel ↔ BD newenia**
- ❌ Laravel NO tiene Models para las 23 tablas de newenia
- ❌ Solo existe `User.php` (mapea tabla Laravel public.users, NO newenia.users)
- ❌ No existe Model para `tenants` ni para ninguna tabla newenia

### **2. Filament Vacío**
- ❌ No hay Resources en `app/Filament/Resources/`
- ❌ Solo dashboard vacío
- ❌ No hay CRUD para ninguna tabla de newenia

### **3. Multi-tenancy Sin Implementar**
- ❌ No existe middleware `SetTenantContext`
- ❌ Laravel no usa la variable `app.tenant_id` de PostgreSQL
- ❌ RLS está activo en BD pero Laravel no lo aprovecha

### **4. Memory Router Incompleto**
- ❌ Servicio básico sin funcionalidad real
- ❌ No usa pgvector ni embeddings
- ❌ Endpoint con errores

### **5. Testing Inadecuado**
- ❌ Solo 4 tests (debería haber 20+)
- ❌ Sin tests para tablas newenia
- ❌ Sin tests de integración BD

---

## 🎯 ROADMAP - DESARROLLO INCREMENTAL

### **FASE 1: FUNDACIÓN (Semana 1-2)** ⭐ AHORA

**Objetivo:** Conectar Laravel con BD newenia

**Tareas:**
- [ ] **G1-DB-T01:** Configurar conexión Laravel → newenia ✅ PRIORITY 1
- [ ] **G1-DB-T02:** Crear NielayModel base con tenant_id
- [ ] **G1-DB-T03:** Models: Tenant, User (newenia)
- [ ] **G1-DB-T04:** Middleware SetTenantContext
- [ ] **G1-DB-T05:** Trait TenantScoped
- [ ] **G1-TEST-T01:** Tests conexión BD (5 tests)

**Entregable:** Laravel conectado a newenia, Models básicos funcionando

---

### **FASE 2: FILAMENT CRUD (Semana 3-4)**

**Objetivo:** Panel admin funcional

**Tareas:**
- [ ] **G2-FIL-T01:** TenantResource (CRUD completo)
- [ ] **G2-FIL-T02:** UserResource (CRUD completo)
- [ ] **G2-FIL-T03:** Roles y permisos
- [ ] **G2-FIL-T04:** Dashboard con métricas
- [ ] **G2-TEST-T01:** Tests Filament Resources (10 tests)

**Entregable:** Panel admin operativo con gestión de tenants/users

---

### **FASE 3: MEMORY ROUTER (Semana 5-6)**

**Objetivo:** Búsqueda semántica con pgvector

**Tareas:**
- [ ] **G3-MR-T01:** Integración pgvector
- [ ] **G3-MR-T02:** Servicio embeddings (OpenAI)
- [ ] **G3-MR-T03:** Búsqueda semántica
- [ ] **G3-MR-T04:** API endpoints funcionales
- [ ] **G3-TEST-T01:** Tests Memory Router (8 tests)

**Entregable:** Memory Router funcional

---

### **FASE 4: AUTOMATION ENGINE (Semana 7-8)**

**Objetivo:** Sistema de jobs y automatizaciones

**Tareas:**
- [ ] **G4-AUTO-T01:** Resources para automation_*
- [ ] **G4-AUTO-T02:** Queue system configurado
- [ ] **G4-AUTO-T03:** Templates reutilizables
- [ ] **G4-TEST-T01:** Tests automation (10 tests)

**Entregable:** Sistema de automatizaciones operativo

---

### **FASE 5: SECURITY & AUDIT (Semana 9-10)**

**Objetivo:** Auditoría completa del sistema

**Tareas:**
- [ ] **G5-SEC-T01:** Dashboard de auditoría
- [ ] **G5-SEC-T02:** Log de requests API
- [ ] **G5-SEC-T03:** API keys management
- [ ] **G5-TEST-T01:** Tests security (8 tests)

**Entregable:** Sistema de auditoría completo

---

### **FASE 6: REVENUE & ANALYTICS (Semana 11-12)**

**Objetivo:** Facturación y métricas

**Tareas:**
- [ ] **G6-REV-T01:** Usage meter dashboard
- [ ] **G6-REV-T02:** Reportes de uso
- [ ] **G6-REV-T03:** Analytics básicos
- [ ] **G6-TEST-T01:** Tests revenue (8 tests)

**Entregable:** Sistema de revenue operativo

---

## 📝 PRÓXIMA ACCIÓN INMEDIATA

### **TAREA CRÍTICA:** G1-DB-T01 - Conectar Laravel a BD newenia

**Lo que vamos a hacer:**
1. Configurar `config/database.php` con conexión 'newenia'
2. Crear `NielayModel.php` base
3. Crear Models: `Tenant.php` y `NeweniaUser.php`
4. Tests de conexión
5. Comando artisan de verificación

**Resultado esperado:**
- Laravel puede consultar tablas de newenia
- Models funcionando
- 5 tests nuevos pasando
- Comando `php artisan nielay:verify-db` operativo

---

## 🔒 REGLAS PARA DEEPAGENT

### **PROHIBIDO:**
- ❌ Modificar estructura BD (ya existe)
- ❌ Crear migraciones para tablas newenia
- ❌ Crear tablas nuevas
- ❌ Modificar RLS policies
- ❌ Asumir sin verificar

### **OBLIGATORIO:**
- ✅ Leer este archivo COMPLETO antes de cada tarea
- ✅ Usar `Schema::hasTable()` antes de crear
- ✅ Usar `class_exists()` antes de generar Models
- ✅ Tests >85% coverage
- ✅ Actualizar este archivo después de cambios

---

## 📊 MÉTRICAS DE ÉXITO

### **Estado Actual:**
- Conexión BD: ❌ No configurada
- Models newenia: ❌ No existen (0/23)
- Tests: 4 (1 falla)
- Coverage: ~40%
- Filament: ❌ Sin Resources

### **Meta Fase 1:**
- Conexión BD: ✅ Funcionando
- Models newenia: ✅ 3 básicos (Tenant, User, Provider)
- Tests: 9 (todos pasando)
- Coverage: >60%

### **Meta Final:**
- Conexión BD: ✅ Optimizada
- Models newenia: ✅ 23/23
- Tests: >50
- Coverage: >85%
- Filament: ✅ Resources completos

---

## 🎯 ARQUITECTURA OBJETIVO

```
Laravel (nielay-erp)
    ↓
config/database.php ['newenia']
    ↓
NielayModel (base)
    ↓
Models específicos (Tenant, User, etc)
    ↓
Middleware SetTenantContext
    ↓
PostgreSQL newenia + RLS
    ↓
app.tenant_id isolation
```

---

**Última actualización:** 07 Noviembre 2025 20:30  
**Estado:** FUNDACIÓN - Listo para G1-DB-T01  
**Siguiente:** Conectar Laravel a BD newenia

---

**FIN DEL DOCUMENTO - MANTENER ACTUALIZADO**
