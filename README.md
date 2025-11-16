# SISTEMA DE GESTIÓN DE CONTEXTO

## USO DIARIO

### Al trabajar con IA:
1. Abrir ESTADO_PROYECTO.md
2. Pedirle a la IA que lo lea
3. Confirmar estado actual
4. Continuar

### Después de un cambio:
```powershell
.\ACTUALIZAR_ESTADO.ps1 -Descripcion "X hecho" -ProximoPaso "Hacer Y"
```

### Ver qué existe:
```powershell
.\VERIFICAR_INFRAESTRUCTURA.ps1
```

## ARCHIVOS
- ESTADO_PROYECTO.md (estado actual)
- ACTUALIZAR_ESTADO.ps1 (actualizar estado)
- VERIFICAR_INFRAESTRUCTURA.ps1 (ver qué existe)
- README.md (este archivo)