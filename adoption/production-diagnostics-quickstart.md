# Conectar herramientas de diagnóstico de producción — Quick Start

**Para quién es**: alguien de un equipo que quiere que un asistente de IA (por ejemplo,
[CAP-017 `production-incident-investigation`](../registry/entries/production-incident-investigation.md))
consulte los logs/errores reales de su aplicación, sin importar si esa aplicación corre en
AWS, Azure o en un servidor propio (on-premise) — las 3 conviven hoy en MOA.

**Los scripts ya existen** — esta guía es solo la parte de "conseguir el acceso"; el
mecanismo real que los usa es
[`../integrations/production-diagnostics-provider.md`](../integrations/production-diagnostics-provider.md)
(AWS y Azure). No hay que escribir ningún código nuevo, solo configurar el acceso de los
pasos de abajo y correr el script correspondiente.

**Antes de empezar, la regla que no cambia nunca**: ningún token ni credencial se guarda en
este repositorio, ni en ningún archivo del modelo. Siempre se configuran como variables de
entorno (o un gestor de secretos) en la computadora o el pipeline de cada equipo — nunca
pegados en un archivo que después se commitea.

**Si tu equipo no tiene ninguna de estas herramientas configurada todavía**: no hace falta
nada de esto para empezar. Se le puede pegar el log o el error real, a mano, directamente en
la conversación con el asistente — así funciona CAP-017 hoy, sin ninguna integración.

## Si tu aplicación usa Azure (Application Insights)

1. Iniciar sesión real de Azure CLI: `az login` (con una cuenta que tenga permiso de
   lectura sobre el recurso de Application Insights de tu equipo — pedíselo a quien lo
   administre si no lo tenés).
2. Pedile a quien administre ese recurso el **App ID** (no es una contraseña, es un
   identificador del recurso) y guardalo como variable de entorno:
   `$env:APPINSIGHTS_APP_ID = "<el App ID que te dieron>"`
3. Correr el script real:
   ```
   ./integrations/scripts/azure-appinsights-diagnostics.ps1 -QueryType recent-exceptions -TimespanHours 24
   ```
4. Si además querés el modo que detecta patrones de error solo, en segundo plano (el
   "Observability Agent" de Azure), necesitás que alguien con permisos de administración de
   la suscripción de Azure de tu equipo te habilite el acceso — no es algo que un
   developer configure por su cuenta, y es independiente del script de arriba.

## Si tu aplicación usa AWS (CloudWatch)

1. Pedile a quien administre la cuenta de AWS de tu equipo un acceso de **solo lectura**
   sobre CloudWatch Logs (nunca de escritura).
2. Guardalo como variables de entorno:
   ```
   $env:AWS_ACCESS_KEY_ID = "<el que te dieron>"
   $env:AWS_SECRET_ACCESS_KEY = "<el que te dieron>"
   $env:AWS_REGION = "us-east-1"
   ```
   (`us-east-1` es la región real donde ya corren aplicaciones de MOA en AWS — confirmalo
   igual con quien te dio el acceso, puede variar por equipo.)
3. Correr el script real (necesita además el nombre real del log group de tu app):
   ```
   ./integrations/scripts/aws-cloudwatch-diagnostics.ps1 -LogGroupName /ecs/<tu-app> -QueryType recent-exceptions -StartTime 2026-09-21T00:00:00Z
   ```

## Si tu aplicación corre on-premise

No hay ningún token que configurar acá. Depende de qué manera de ver logs ya tenga tu
equipo hoy (archivos de log locales, un servidor de logs propio). Si tu equipo todavía no
tiene ninguna, es una conversación con quien gobierne esa infraestructura dentro de MOA —
este modelo no la resuelve por sí solo.

## Resumen

| Dónde corre tu app | Qué necesitás pedir | A quién | Script real |
|---|---|---|---|
| Azure | Sesión `az login` + App ID de Application Insights | Administrador del recurso de Azure de tu equipo | `azure-appinsights-diagnostics.ps1` |
| AWS | Acceso de solo lectura a CloudWatch Logs + nombre del log group | Administrador de la cuenta de AWS de tu equipo | `aws-cloudwatch-diagnostics.ps1` |
| On-premise | Depende de la herramienta de logs que ya tengan | Quien gobierne esa infraestructura en tu equipo |
| Ninguna configurada todavía | Nada — pegá el log a mano | No hace falta pedir nada |
