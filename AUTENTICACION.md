# Autenticación en ARASAAC API

## 📌 Estado actual

La aplicación **NO requiere autenticación** porque utiliza únicamente endpoints públicos de solo lectura:

- ✅ `GET /api/pictograms/{lang}/search/{query}` - Búsqueda pública
- ✅ `GET /api/pictograms/{lang}/search/category/{category}` - Por categoría
- ✅ `GET /api/categories/{lang}` - Obtener categorías
- ✅ `GET /api/pictograms/{lang}/bestsellers` - Mejores pictogramas
- ✅ Descarga de imágenes desde `static.arasaac.org` - Público

## 🔐 Sistema de autenticación disponible

ARASAAC proporciona autenticación **OAuth 2.0** en: **https://auth.arasaac.org/**

### Flujos OAuth 2.0 soportados

#### 1. Authorization Code (Recomendado para aplicaciones web)
```
Endpoint: /dialog/authorize
Parámetros:
  - client_id=abc123
  - response_type=code
  - scope=offline_access
```

#### 2. Implicit Flow (Para clientes públicos)
```
Endpoint: /dialog/authorize
Parámetros:
  - client_id=abc123
  - response_type=token
```

#### 3. Resource Owner Password Credentials
```
POST /oauth/token
Authorization: Basic base64(client_id:client_secret)
Body:
  - username
  - password
  - grant_type=password
```

#### 4. Client Credentials
```
POST /oauth/token
Authorization: Basic base64(client_id:client_secret)
Body:
  - grant_type=client_credentials
```

### Uso del token

Una vez obtenido el token de acceso, se incluye en los headers:

```
Authorization: Bearer {access_token}
```

## 🚀 Cuándo necesitas autenticación

La autenticación es necesaria para:

- **Gestión de usuarios**: Perfiles, preferencias
- **Operaciones de escritura**: Crear/modificar pictogramas
- **Datos privados**: Colecciones personales, favoritos
- **Endpoints privados**: API administrativa
- **Rate limiting elevado**: Más peticiones por minuto

## 📝 Cómo implementar autenticación (si es necesario en el futuro)

### Paso 1: Registrar tu aplicación

Contacta con ARASAAC para obtener:
- `client_id`
- `client_secret`
- Configurar redirect URLs

### Paso 2: Añadir dependencias

Añade a `pubspec.yaml`:
```yaml
dependencies:
  oauth2: ^2.0.2
  flutter_secure_storage: ^9.0.0
```

### Paso 3: Implementar servicio de autenticación

```dart
import 'package:oauth2/oauth2.dart' as oauth2;

class AuthService {
  static const authorizationEndpoint =
    Uri.parse('https://auth.arasaac.org/dialog/authorize');
  static const tokenEndpoint =
    Uri.parse('https://auth.arasaac.org/oauth/token');

  static const identifier = 'YOUR_CLIENT_ID';
  static const secret = 'YOUR_CLIENT_SECRET';
  static const redirectUrl = Uri.parse('http://localhost:8080/callback');

  Future<oauth2.Client> authenticate() async {
    var grant = oauth2.AuthorizationCodeGrant(
      identifier,
      authorizationEndpoint,
      tokenEndpoint,
      secret: secret,
    );

    var authorizationUrl = grant.getAuthorizationUrl(redirectUrl);

    // Redirigir al usuario a authorizationUrl
    // Obtener el código de autorización

    // Intercambiar código por token
    var client = await grant.handleAuthorizationResponse(queryParameters);

    return client;
  }
}
```

### Paso 4: Actualizar ArasaacApiService

```dart
class ArasaacApiService {
  final oauth2.Client? _authenticatedClient;

  ArasaacApiService({oauth2.Client? client})
    : _authenticatedClient = client;

  Future<List<Pictogram>> searchWithAuth(String query) async {
    final headers = _authenticatedClient != null
      ? {'Authorization': 'Bearer ${_authenticatedClient!.credentials.accessToken}'}
      : {};

    final response = await http.get(url, headers: headers);
    // ...
  }
}
```

### Paso 5: Añadir pantalla de login

```dart
class LoginScreen extends StatelessWidget {
  Future<void> _login(BuildContext context) async {
    final authService = AuthService();
    final client = await authService.authenticate();

    // Guardar cliente autenticado
    Provider.of<AuthProvider>(context, listen: false)
      .setAuthenticatedClient(client);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _login(context),
          child: Text('Iniciar sesión con ARASAAC'),
        ),
      ),
    );
  }
}
```

## 🔄 Endpoints que podrían requerir autenticación

Aunque actualmente no se usan en la app, estos podrían necesitar auth:

- `POST /api/pictograms` - Crear pictograma
- `PUT /api/pictograms/{id}` - Actualizar pictograma
- `DELETE /api/pictograms/{id}` - Eliminar pictograma
- `GET /api/users/favorites` - Favoritos del usuario
- `POST /api/users/favorites` - Añadir a favoritos
- `GET /api/users/profile` - Perfil del usuario

## 📚 Recursos adicionales

- **Portal OAuth**: https://auth.arasaac.org/
- **API pública**: https://github.com/Arasaac/public-api
- **Documentación**: https://beta.arasaac.org/developers/api

## ✅ Conclusión

Para el caso de uso actual (buscar, visualizar y descargar pictogramas), **NO necesitas autenticación**. La API pública es suficiente y funciona perfectamente sin credenciales.

Solo necesitarías implementar OAuth2 si en el futuro quisieras:
- Permitir que los usuarios guarden favoritos
- Crear/modificar pictogramas
- Acceder a datos privados
- Funcionalidades administrativas

La aplicación actual está optimizada y lista para usar sin complicaciones adicionales.
