# 🤖 PROMPT DEEPAGENT G1-DB-T01 - Conexión Laravel BD Newenia

**ID Tarea:** G1-DB-T01  
**Fase:** 1 - Fundación  
**Prioridad:** 🔴 CRÍTICA  
**Estimación:** 2-3 horas

---

## 📋 CONTEXTO OBLIGATORIO

**LEER PRIMERO:**
- `/var/www/nielay-system/docs/ESTADO_PROYECTO.md` (COMPLETO)

**Verificar antes de empezar:**
```bash
# Ver estado real de BD
psql -U postgres -d newenia -h 127.0.0.1 -c "\dt newenia_global_core.*"
```

---

## 🎯 OBJETIVO

Conectar Laravel con la base de datos `newenia` que ya existe en el servidor con 23 tablas distribuidas en 8 schemas.

**NO crear migraciones** - La BD ya existe con estructura completa.

---

## 📊 BASE DE DATOS REAL (23 TABLAS)

### **Estructura existente:**
```
newenia_ai_universal        (2 tablas)
newenia_automation_engine   (4 tablas)
newenia_document_processing (2 tablas)
newenia_global_core         (2 tablas)  ← PRIORIDAD
newenia_revenue_core        (1 tabla)
newenia_security_audit      (2 tablas)
newenia_vector_storage      (1 tabla)
public                      (9 tablas Laravel)
```

### **Tablas críticas para conectar PRIMERO:**
1. `newenia_global_core.tenants` ← Multi-tenancy
2. `newenia_global_core.users` ← Usuarios sistema
3. `newenia_ai_universal.ai_providers_global` ← Config IA

---

## ✅ REQUISITOS

### **1. Actualizar config/database.php**

Agregar conexión específica `newenia`:

```php
// config/database.php

'connections' => [
    
    // Conexión default Laravel (NO tocar)
    'pgsql' => [
        'driver' => 'pgsql',
        'host' => env('DB_HOST', '127.0.0.1'),
        'port' => env('DB_PORT', '5432'),
        'database' => env('DB_DATABASE', 'forge'),
        'username' => env('DB_USERNAME', 'forge'),
        'password' => env('DB_PASSWORD', ''),
        'charset' => 'utf8',
        'prefix' => '',
        'prefix_indexes' => true,
        'search_path' => 'public',
        'sslmode' => 'prefer',
    ],
    
    // Nueva conexión newenia
    'newenia' => [
        'driver' => 'pgsql',
        'host' => env('DB_HOST', '127.0.0.1'),
        'port' => env('DB_PORT', '5432'),
        'database' => 'newenia',  // Base de datos newenia
        'username' => env('DB_USERNAME', 'postgres'),
        'password' => env('DB_PASSWORD', ''),
        'charset' => 'utf8',
        'prefix' => '',
        'prefix_indexes' => true,
        // Schemas principales en search_path
        'search_path' => 'newenia_global_core,newenia_ai_universal,newenia_vector_storage,public',
        'sslmode' => 'prefer',
    ],
],
```

---

### **2. Crear Model Base: NielayModel.php**

**Ubicación:** `app/Models/NielayModel.php`

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Base Model para todas las tablas de newenia
 * 
 * IMPORTANTE:
 * - Usa conexión 'newenia'
 * - Soporte multi-schema
 * - Compatible con RLS de PostgreSQL
 */
abstract class NielayModel extends Model
{
    /**
     * Conexión a BD newenia
     */
    protected $connection = 'newenia';
    
    /**
     * Timestamps estándar
     */
    public $timestamps = true;
    
    /**
     * Campos protegidos por defecto
     */
    protected $guarded = ['id'];
    
    /**
     * Casteos comunes
     */
    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];
    
    /**
     * Helper para queries cross-schema
     */
    public function getFullTableName(): string
    {
        return $this->getTable();
    }
}
```

---

### **3. Model: Tenant.php**

Mapea tabla `newenia_global_core.tenants`

**Ubicación:** `app/Models/Tenant.php`

```php
<?php

namespace App\Models;

/**
 * Model para tenants (clientes multi-tenant)
 * 
 * Tabla: newenia_global_core.tenants
 * PK: id
 */
class Tenant extends NielayModel
{
    /**
     * Nombre completo de tabla (incluye schema)
     */
    protected $table = 'newenia_global_core.tenants';
    
    /**
     * Primary key
     */
    protected $primaryKey = 'id';
    
    /**
     * Campos fillable
     */
    protected $fillable = [
        'name',
        'slug',
        'domain',
        'database',
        'is_active',
        'metadata',
    ];
    
    /**
     * Casteos
     */
    protected $casts = [
        'is_active' => 'boolean',
        'metadata' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];
    
    /**
     * Relación con usuarios
     */
    public function users()
    {
        return $this->hasMany(NeweniaUser::class, 'tenant_id', 'id');
    }
}
```

---

### **4. Model: NeweniaUser.php**

Mapea tabla `newenia_global_core.users`

**Ubicación:** `app/Models/NeweniaUser.php`

```php
<?php

namespace App\Models;

/**
 * Model para usuarios del sistema newenia
 * 
 * Tabla: newenia_global_core.users
 * PK: id
 * 
 * IMPORTANTE: Este NO es el User de Laravel
 * Este mapea la tabla de newenia
 */
class NeweniaUser extends NielayModel
{
    /**
     * Nombre completo de tabla
     */
    protected $table = 'newenia_global_core.users';
    
    /**
     * Primary key
     */
    protected $primaryKey = 'id';
    
    /**
     * Campos fillable
     */
    protected $fillable = [
        'tenant_id',
        'name',
        'email',
        'password',
        'is_active',
        'metadata',
    ];
    
    /**
     * Hidden fields
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];
    
    /**
     * Casteos
     */
    protected $casts = [
        'tenant_id' => 'integer',
        'is_active' => 'boolean',
        'metadata' => 'array',
        'email_verified_at' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];
    
    /**
     * Relación con tenant
     */
    public function tenant()
    {
        return $this->belongsTo(Tenant::class, 'tenant_id', 'id');
    }
}
```

---

### **5. Model: AIProvider.php**

Mapea tabla `newenia_ai_universal.ai_providers_global`

**Ubicación:** `app/Models/AIProvider.php`

```php
<?php

namespace App\Models;

/**
 * Model para proveedores de IA (OpenAI, Claude, Ollama)
 * 
 * Tabla: newenia_ai_universal.ai_providers_global
 * PK: id
 */
class AIProvider extends NielayModel
{
    /**
     * Nombre completo de tabla
     */
    protected $table = 'newenia_ai_universal.ai_providers_global';
    
    /**
     * Primary key
     */
    protected $primaryKey = 'id';
    
    /**
     * Campos fillable
     */
    protected $fillable = [
        'name',
        'type',
        'api_endpoint',
        'api_key',
        'is_active',
        'config',
        'metadata',
    ];
    
    /**
     * Hidden fields
     */
    protected $hidden = [
        'api_key',
    ];
    
    /**
     * Casteos
     */
    protected $casts = [
        'is_active' => 'boolean',
        'config' => 'array',
        'metadata' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];
}
```

---

### **6. Test: NeweniaDatabaseConnectionTest.php**

**Ubicación:** `tests/Feature/NeweniaDatabaseConnectionTest.php`

```php
<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use App\Models\Tenant;
use App\Models\NeweniaUser;
use App\Models\AIProvider;

class NeweniaDatabaseConnectionTest extends TestCase
{
    /** @test */
    public function can_connect_to_newenia_database()
    {
        $connection = DB::connection('newenia');
        $this->assertNotNull($connection->getPdo());
    }
    
    /** @test */
    public function newenia_connection_uses_correct_database()
    {
        $dbName = DB::connection('newenia')
            ->select('SELECT current_database()')[0]->current_database;
        
        $this->assertEquals('newenia', $dbName);
    }
    
    /** @test */
    public function can_query_tenants_table()
    {
        $count = Tenant::count();
        $this->assertIsInt($count);
    }
    
    /** @test */
    public function can_query_users_table()
    {
        $count = NeweniaUser::count();
        $this->assertIsInt($count);
    }
    
    /** @test */
    public function can_query_ai_providers_table()
    {
        $count = AIProvider::count();
        $this->assertIsInt($count);
    }
    
    /** @test */
    public function tenant_model_has_correct_table()
    {
        $tenant = new Tenant();
        $this->assertEquals('newenia_global_core.tenants', $tenant->getTable());
    }
    
    /** @test */
    public function user_model_has_correct_table()
    {
        $user = new NeweniaUser();
        $this->assertEquals('newenia_global_core.users', $user->getTable());
    }
    
    /** @test */
    public function can_verify_pgvector_extension()
    {
        $extensions = DB::connection('newenia')
            ->select("SELECT extname FROM pg_extension WHERE extname = 'vector'");
        
        $this->assertCount(1, $extensions);
        $this->assertEquals('vector', $extensions[0]->extname);
    }
    
    /** @test */
    public function can_verify_all_schemas_exist()
    {
        $schemas = DB::connection('newenia')
            ->select("SELECT schema_name FROM information_schema.schemata WHERE schema_name LIKE 'newenia%' ORDER BY schema_name");
        
        $schemaNames = array_map(fn($s) => $s->schema_name, $schemas);
        
        $expectedSchemas = [
            'newenia_ai_universal',
            'newenia_automation_engine',
            'newenia_document_processing',
            'newenia_global_core',
            'newenia_revenue_core',
            'newenia_security_audit',
            'newenia_vector_storage',
        ];
        
        foreach ($expectedSchemas as $schema) {
            $this->assertContains($schema, $schemaNames, "Schema $schema no encontrado");
        }
    }
}
```

---

### **7. Comando: VerifyNeweniaConnection.php**

**Ubicación:** `app/Console/Commands/VerifyNeweniaConnection.php`

```php
<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use App\Models\Tenant;
use App\Models\NeweniaUser;
use App\Models\AIProvider;

class VerifyNeweniaConnection extends Command
{
    protected $signature = 'nielay:verify-db';
    
    protected $description = 'Verifica conexión a BD newenia y muestra estadísticas';
    
    public function handle()
    {
        $this->info('🔍 Verificando conexión a BD newenia...');
        $this->newLine();
        
        try {
            // Test conexión
            $connection = DB::connection('newenia');
            $connection->getPdo();
            $this->info('✅ Conexión establecida');
            
            // Base de datos
            $dbName = $connection->select('SELECT current_database()')[0]->current_database;
            $this->info("✅ Base de datos: $dbName");
            
            // PostgreSQL version
            $version = $connection->select('SELECT version()')[0]->version;
            preg_match('/PostgreSQL (\d+\.\d+)/', $version, $matches);
            $this->info("✅ PostgreSQL: " . ($matches[1] ?? 'unknown'));
            
            // Contar schemas
            $schemas = $connection->select("SELECT COUNT(*) as total FROM information_schema.schemata WHERE schema_name LIKE 'newenia%'");
            $this->info("✅ Schemas newenia: " . $schemas[0]->total);
            
            // Contar tablas
            $tables = $connection->select("SELECT COUNT(*) as total FROM information_schema.tables WHERE table_schema LIKE 'newenia%'");
            $this->info("✅ Tablas newenia: " . $tables[0]->total);
            
            // Extensiones
            $extensions = $connection->select("SELECT extname FROM pg_extension WHERE extname IN ('vector', 'pg_trgm', 'pgcrypto')");
            $this->info("✅ Extensiones activas: " . count($extensions));
            foreach ($extensions as $ext) {
                $this->line("   - $ext->extname");
            }
            
            $this->newLine();
            $this->info('📊 Datos en tablas principales:');
            
            // Test Models
            $tenantCount = Tenant::count();
            $userCount = NeweniaUser::count();
            $providerCount = AIProvider::count();
            
            $this->line("   - Tenants: $tenantCount");
            $this->line("   - Users: $userCount");
            $this->line("   - AI Providers: $providerCount");
            
            $this->newLine();
            $this->info("🎉 ¡Todo funcionando correctamente!");
            
            return Command::SUCCESS;
            
        } catch (\Exception $e) {
            $this->newLine();
            $this->error('❌ Error: ' . $e->getMessage());
            return Command::FAILURE;
        }
    }
}
```

---

## 🚫 PROHIBIDO

- ❌ NO crear migraciones para tablas newenia
- ❌ NO modificar estructura BD
- ❌ NO crear tablas
- ❌ NO modificar tablas existentes
- ❌ NO tocar `database/migrations/` (excepto agregar nuevas si necesario)
- ❌ NO duplicar funcionalidad existente

---

## ✅ DEFINITION OF DONE

1. ✅ `config/database.php` tiene conexión 'newenia'
2. ✅ `app/Models/NielayModel.php` creado
3. ✅ `app/Models/Tenant.php` creado y funcional
4. ✅ `app/Models/NeweniaUser.php` creado y funcional
5. ✅ `app/Models/AIProvider.php` creado y funcional
6. ✅ `tests/Feature/NeweniaDatabaseConnectionTest.php` creado con 9 tests
7. ✅ `app/Console/Commands/VerifyNeweniaConnection.php` creado
8. ✅ TODOS los tests pasan (4 existentes + 9 nuevos = 13 total)
9. ✅ Comando `php artisan nielay:verify-db` ejecuta sin errores
10. ✅ Sin errores PHP syntax en archivos nuevos

---

## 📊 ENTREGABLES

### **Archivos a modificar:**
- `config/database.php` (agregar conexión 'newenia')

### **Archivos a crear:**
- `app/Models/NielayModel.php`
- `app/Models/Tenant.php`
- `app/Models/NeweniaUser.php`
- `app/Models/AIProvider.php`
- `tests/Feature/NeweniaDatabaseConnectionTest.php`
- `app/Console/Commands/VerifyNeweniaConnection.php`

### **Comandos de verificación:**
```bash
# 1. Verificar sintaxis
php -l app/Models/NielayModel.php
php -l app/Models/Tenant.php
php -l app/Models/NeweniaUser.php
php -l app/Models/AIProvider.php
php -l tests/Feature/NeweniaDatabaseConnectionTest.php
php -l app/Console/Commands/VerifyNeweniaConnection.php

# 2. Ejecutar tests
php artisan test --filter=NeweniaDatabaseConnection

# 3. Verificar conexión
php artisan nielay:verify-db
```

---

## 🎯 RESULTADO ESPERADO

```bash
$ php artisan nielay:verify-db

🔍 Verificando conexión a BD newenia...

✅ Conexión establecida
✅ Base de datos: newenia
✅ PostgreSQL: 14.19
✅ Schemas newenia: 7
✅ Tablas newenia: 14
✅ Extensiones activas: 3
   - vector
   - pg_trgm
   - pgcrypto

📊 Datos en tablas principales:
   - Tenants: 0
   - Users: 0
   - AI Providers: 0

🎉 ¡Todo funcionando correctamente!
```

---

## 📝 ACTUALIZACIÓN POST-IMPLEMENTACIÓN

Agregar al final de `/var/www/nielay-system/docs/ESTADO_PROYECTO.md`:

```markdown
### [2025-11-07 21:00] - G1-DB-T01 COMPLETADO ✅

**Conexión Laravel ↔ BD newenia configurada:**
- ✅ config/database.php con conexión 'newenia'
- ✅ NielayModel base creado
- ✅ Models: Tenant, NeweniaUser, AIProvider funcionando
- ✅ 9 tests nuevos (todos pasando)
- ✅ Comando nielay:verify-db operativo
- ✅ Sin errores de sintaxis

**Tests totales:** 13 (4 previos + 9 nuevos)  
**Estado:** Laravel conectado a newenia ✅  
**Siguiente:** G1-DB-T02 - Middleware SetTenantContext
```

---

**FIN DEL PROMPT**
