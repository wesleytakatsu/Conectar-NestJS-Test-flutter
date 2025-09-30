# 📱 Conéctar App - Sistema de Gerenciamento de Usuários Flutter

<div align="center">
  
  ![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-SDK-0175C2?logo=dart&logoColor=white)
  ![Provider](https://img.shields.io/badge/Provider-State%20Management-green)
  ![Firebase](https://img.shields.io/badge/Firebase-Integrated-orange?logo=firebase)
  ![Tests](https://img.shields.io/badge/Tests-59%20Tests%20%E2%9C%85-brightgreen)

  **Aplicação Flutter completa para gerenciamento de usuários e empresas com autenticação JWT e integração Firebase**

</div>

---

## 🌐 Live Demo

**🎯 Acesse a aplicação online:** [https://conectarteste.pages.dev/](https://conectarteste.pages.dev/)  
**Acesse o teste com Swagger da API:** [https://discussing-around-attorney-prototype.trycloudflare.com/api/](https://discussing-around-attorney-prototype.trycloudflare.com/api/)  
Ou baixe uma versão release aqui no GitHub.

**Credenciais padrão do admin:**
- Email: `admin@conectar.com`
- Senha: `admin123`

* OBS: Login com o Google disponível só no Android.
Na versão Web só se rodar em ambiente local com as credenciais que eu posso passar por ter chaves confidenciais.
Na Cloudflare Pages grátis não é permitido usar Oauth do Google.

Meu contato do WhatsApp: (21) 97526-3910

## 🎯 Sobre o Projeto

O **Conectar App** é uma aplicação Flutter desenvolvida como parte de um teste técnico para a empresa Conéctar. O projeto demonstra a implementação de um sistema completo de gerenciamento de usuários com foco na **arquitetura limpa**, **segurança** e **experiência do usuário**.

### 🌟 Principais Características

- ✅ **Autenticação Completa**: JWT + Google Sign-In
- ✅ **Interface Responsiva**: Adaptável para mobile, tablet e desktop
- ✅ **Gerenciamento de Estado**: Provider pattern implementado
- ✅ **Segurança**: Flutter Secure Storage para tokens
- ✅ **Testes Abrangentes**: 59+ testes automatizados
- ✅ **Integração Firebase**: Autenticação e analytics
- ✅ **API REST**: Integração completa com backend NestJS

---

## 🏗️ Arquitetura e Tecnologias

### 📋 Justificativas Técnicas (Conforme Requisitos)

#### **Gerenciamento de Estado: Provider**
- **Escolha**: Provider foi selecionado por sua **simplicidade**, **performance** e **integração nativa** com o Flutter
- **Vantagens**:
  - Reatividade automática da UI
  - Baixo acoplamento entre camadas
  - Facilita testes unitários
- **Implementação**: Controllers separados por feature (Auth, Users, Company)

#### **Roteamento: GoRouter**
- **Escolha**: GoRouter oferece roteamento **declarativo** e **type-safe**
- **Vantagens**:
  - Suporte nativo a deep linking
  - Proteção de rotas com redirect
  - Navegação programática robusta
  - Melhor performance para aplicações web

#### **Cliente HTTP: Dio**
- **Escolha**: Dio supera o http padrão em **funcionalidades** e **flexibilidade**
- **Vantagens**:
  - Interceptors para autenticação automática
  - Tratamento avançado de erros
  - Request/Response transformation
  - Suporte a timeouts configuráveis

### 🛠️ Stack Tecnológica

#### **Core Framework**
- **Flutter SDK**: `^3.9.2` - Framework multiplataforma
- **Dart**: Linguagem de programação principal

#### **Gerenciamento de Estado**
- **Provider**: `^6.1.2` - Injeção de dependências e estado reativo

#### **Networking & API**
- **Dio**: `^5.9.0` - Cliente HTTP avançado
- **Flutter Secure Storage**: `^9.2.4` - Armazenamento seguro de tokens

#### **Navegação & Routing**
- **Go Router**: `^16.2.4` - Roteamento declarativo type-safe

#### **Autenticação & Firebase**
- **Firebase Core**: `^4.1.1` - Core Firebase SDK
- **Firebase Auth**: `^6.1.0` - Autenticação Firebase
- **Google Sign In**: `^6.2.2` - Login com Google

#### **UI/UX**
- **Google Fonts**: `^6.1.0` - Tipografia customizada
- **Data Table 2**: `^2.6.0` - Tabelas avançadas
- **Cached Network Image**: `^3.4.1` - Cache de imagens

#### **Configuração & Ambiente**
- **Flutter DotEnv**: `^5.1.0` - Gerenciamento de variáveis de ambiente

#### **Testes**
- **Mockito**: `^5.5.1` - Mocks para testes
- **HTTP Mock Adapter**: `^0.6.1` - Mocks de requisições HTTP
- **Build Runner**: `^2.4.12` - Geração de código para testes

---

## 🚀 Como Executar o Projeto

### 📋 Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

```bash
# Flutter SDK 3.9.2+
flutter --version

# Dart SDK (incluído no Flutter)
dart --version

# Git
git --version
```

### 🔧 Configuração do Ambiente

1. **Clone o repositório:**
```bash
gh repo clone wesleytakatsu/Conectar-NestJS-Test-flutter
cd Conectar-NestJS-Test-flutter
```

2. **Instale as dependências:**
```bash
flutter pub get
```

3. **Configure o arquivo de ambiente:**
```bash
# Crie o arquivo .env na raiz do projeto
cp .env.example .env

# Adicione o .env com as variáveis na raiz
Solicite o arquivo por WhatsApp (21) 97526-3910
Ou se quiser, configure a sua maneira
```

4. **Configure o Firebase (Opcional):**
```bash
Solicite o arquivo por WhatsApp (21) 97526-3910
Ou se quiser, configure a sua maneira
# Se usando Firebase, configure o projeto:
# - Adicione google-services.json (Android)
# - Configure firebase_options.dart
```

### ▶️ Executando a Aplicação

#### **Mobile/Desktop Development**
```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Específico para web
flutter run -d chrome

# Específico para Android
flutter run -d android

# Específico para iOS
flutter run -d ios
```

#### **Build para Produção**
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (macOS required)
flutter build ios --release

# Web
flutter build web --release
```

---

## ✨ Funcionalidades Implementadas

### 🔐 **Autenticação Robusta**

#### **Login JWT Nativo**
- ✅ Validação de credenciais em tempo real
- ✅ Armazenamento seguro de tokens JWT
- ✅ Auto-redirect baseado no status de autenticação
- ✅ Tratamento de erros com feedback visual

#### **Autenticação Social**
- ✅ **Google Sign-In**: Integração completa
- ✅ **Firebase Auth**: Backup de autenticação
- ✅ **Logout Seguro**: Limpeza de tokens e sessões

```dart
// Exemplo de uso do AuthController
final authController = context.read<AuthController>();
await authController.login(email, password);
```

### 👥 **Gerenciamento de Usuários**

#### **Para Administradores**
- ✅ **Listagem Completa**: Todos os usuários do sistema
- ✅ **Filtros Avançados**: Por role, status, nome, data
- ✅ **Ordenação**: Por nome, data de criação, último login
- ✅ **CRUD Completo**: Criar, editar, visualizar, deletar
- ✅ **Busca em Tempo Real**: Sistema de pesquisa responsivo

#### **Para Usuários Regulares**
- ✅ **Perfil Pessoal**: Visualização e edição de dados próprios
- ✅ **Alteração de Senha**: Com validações de segurança
- ✅ **Upload de Avatar**: Integração com storage

### 🏢 **Gerenciamento de Empresas**

#### **Sistema Completo de Empresas**
- ✅ **Cadastro Empresarial**: Formulários com validação CNPJ
- ✅ **Listagem com Filtros**: Status, região, tipo
- ✅ **Edição Avançada**: Dados cadastrais e endereço
- ✅ **Validações**: CPF, CNPJ, CEP com formatação automática

```dart
// Exemplo de formatação automática
TextFormField(
  inputFormatters: [CNPJFormatter()],
  validator: (value) => CNPJValidator.validate(value),
)
```

### 🎨 **Interface de Usuário**

#### **Design Responsivo**
- ✅ **Mobile First**: Otimizado para dispositivos móveis
- ✅ **Tablet Support**: Layout adaptativo para tablets
- ✅ **Desktop Ready**: Interface completa para desktop/web
- ✅ **Dark/Light Mode**: Suporte a temas (preparado)

#### **Componentes Reutilizáveis**
- ✅ **Conectar Logo**: Component animado da marca
- ✅ **Login Card**: Card responsivo de autenticação
- ✅ **Data Tables**: Tabelas avançadas com paginação
- ✅ **Form Components**: Inputs com validação integrada
- ✅ **Loading States**: Indicadores de carregamento consistentes

### 🔒 **Segurança Implementada**

#### **Proteção de Dados**
- ✅ **JWT Tokens**: Armazenamento seguro com Flutter Secure Storage
- ✅ **Route Guards**: Proteção automática de rotas
- ✅ **Token Refresh**: Renovação automática de tokens
- ✅ **Session Management**: Controle de sessões expiradas

#### **Validações**
- ✅ **Input Validation**: Validação client-side robusta
- ✅ **CNPJ/CPF**: Algoritmos de validação brasileiros
- ✅ **Email/Phone**: Formatação e validação internacional
- ✅ **Password Policy**: Regras de senha configuráveis

### 📊 **Filtros e Busca**

#### **Sistema de Filtros Avançado**
- ✅ **Filtros Expansíveis**: Interface limpa e intuitiva
- ✅ **Múltiplos Critérios**: Combinação de filtros simultâneos
- ✅ **Persistência**: Mantém filtros entre navegações
- ✅ **Reset Inteligente**: Limpeza seletiva de filtros

#### **Busca em Tempo Real**
```dart
// Implementação do filtro de busca
void _handleSearch(String query) {
  final controller = context.read<UsersController>();
  controller.filterUsers(
    name: query,
    role: selectedRole,
    status: selectedStatus,
  );
}
```

---

## 🧪 Testes Automatizados

### 📈 **Cobertura de Testes**

```
✅ 59+ Testes Implementados
📁 4 Arquivos de Teste
🚀 100% da Infraestrutura Coberta
```

#### **Estrutura de Testes**
```
test/
├── unit/ (34 testes)
│   ├── models/
│   │   ├── user_test.dart        # 18 testes
│   │   └── company_test.dart     # 16 testes
│   ├── controllers/              # Lógica de negócio
│   └── utils/                    # Formatadores e validadores
├── widget/ (10 testes)
│   └── login_view_test.dart      # Interface e interações
├── integration/ (15 testes)
│   └── app_integration_test.dart # Fluxos completos
└── test_helpers.dart             # Utilities e mocks
```

### 🔬 **Tipos de Testes**

#### **Testes Unitários**
- ✅ **Modelos**: Serialização JSON, validações
- ✅ **Controladores**: Estados, lógica de negócio
- ✅ **Serviços**: APIs, tratamento de erros
- ✅ **Utilitários**: Formatadores, validadores

#### **Testes de Widget**
- ✅ **UI Components**: Renderização correta
- ✅ **Interações**: Taps, inputs, navegação
- ✅ **Estados**: Loading, error, success
- ✅ **Responsividade**: Diferentes tamanhos de tela

#### **Testes de Integração**
- ✅ **Fluxos End-to-End**: Login completo
- ✅ **Navegação**: Entre telas
- ✅ **API Integration**: Mocks de requisições
- ✅ **Performance**: Tempos de resposta

### ▶️ **Executando Testes**

```bash
# Todos os testes
flutter test

# Testes específicos
flutter test test/unit/models/user_test.dart

# Com cobertura
flutter test --coverage

# Modo watch
flutter test --watch
```

---

## 📁 Estrutura do Projeto

### 🏗️ **Arquitetura Limpa**

```
lib/
├── main.dart                     # Entry point da aplicação
├── config/
│   └── app_config.dart          # Configurações globais
├── controllers/                 # Provider Controllers
│   ├── auth_controller.dart     # Gerenciamento de autenticação
│   ├── users_controller.dart    # Gerenciamento de usuários
│   └── company_controller.dart  # Gerenciamento de empresas
├── models/                      # Modelos de dados
│   ├── user.dart               # Modelo User
│   ├── company.dart            # Modelo Company
│   └── client.dart             # Modelo Client
├── services/                   # Camada de serviços
│   ├── auth_service.dart       # Serviços de autenticação
│   ├── user_service.dart       # Serviços de usuário
│   ├── company_service.dart    # Serviços de empresa
│   └── google_auth_service.dart # Integração Google
├── views/                      # Telas da aplicação
│   ├── login_view.dart         # Tela de login
│   ├── home_view.dart          # Dashboard principal
│   ├── users_list_view.dart    # Listagem de usuários
│   ├── user_form_view.dart     # Formulário de usuário
│   ├── profile_view.dart       # Perfil do usuário
│   └── company_*.dart          # Telas de empresa
├── widgets/                    # Componentes reutilizáveis
│   ├── buttons/                # Botões customizados
│   ├── cards/                  # Cards e containers
│   ├── forms/                  # Componentes de formulário
│   ├── navigation/             # Navegação e drawer
│   ├── tables/                 # Tabelas de dados
│   └── common/                 # Componentes gerais
├── routes/
│   └── app_routes.dart         # Configuração de rotas
├── utils/
│   └── input_formatters.dart   # Formatadores e validadores
└── firebase_options.dart       # Configuração Firebase
```

### 🎯 **Separação de Responsabilidades**

#### **Controllers (Providers)**
- **Responsabilidade**: Gerenciamento de estado da aplicação
- **Princípio**: Single Responsibility, cada controller gerencia uma feature específica
- **Exemplo**: `AuthController` apenas para autenticação

#### **Services**
- **Responsabilidade**: Comunicação com APIs externas
- **Princípio**: Abstração da camada de dados
- **Exemplo**: `AuthService` encapsula todas as chamadas de auth

#### **Models**
- **Responsabilidade**: Representação e serialização de dados
- **Princípio**: Data Transfer Objects (DTOs)
- **Exemplo**: `User.fromJson()` e `User.toJson()`

#### **Views**
- **Responsabilidade**: Apresentação e interação do usuário
- **Princípio**: UI separada da lógica de negócio
- **Exemplo**: Views apenas consomem dados dos Controllers

---

## 🔧 Configuração Avançada

### ⚙️ **Variáveis de Ambiente**

Crie um arquivo `.env` na raiz do projeto:

```env
# API Configuration
API_URL=http://localhost:3000
CONNECTION_TIMEOUT=10
RECEIVE_TIMEOUT=10

# Debug
DEBUG_LOGS=true

# Firebase (opcional)
FIREBASE_PROJECT_ID=your-project-id
```

### 🔐 **Configuração Firebase**

1. **Crie um projeto no Firebase Console**
2. **Adicione o app Flutter ao projeto**
3. **Baixe o arquivo de configuração:**
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`

4. **Configure as dependências:**
```bash
# Instale o Firebase CLI
npm install -g firebase-tools

# Configure o projeto
firebase login
firebase projects:list
flutterfire configure
```

### 📱 **Configurações Específicas por Plataforma**

#### **Android**
```gradle
// android/app/build.gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
        multiDexEnabled true
    }
}
```

#### **iOS**
```gradle
<!-- ios/Runner/Info.plist -->
<key>CFBundleURLSchemes</key>
<array>
    <string>your-app-scheme</string>
</array>
```

#### **Web**
```html
<!-- web/index.html -->
<script src="https://apis.google.com/js/platform.js"></script>
```

---

## 🔍 Debugging e Troubleshooting

### 🐛 **Problemas Comuns**

#### **1. Erro de Conexão com Backend**
```bash
# Verifique se o backend está rodando
curl http://localhost:3000/health

# Verifique a configuração da API_URL
cat .env
```

#### **2. Problemas com Firebase**
```bash
# Verifique a configuração
flutter packages get
flutterfire configure --reconfigure
```

#### **3. Testes Falhando**
```bash
# Limpe o cache
flutter clean
flutter pub get

# Execute testes específicos
flutter test test/unit/
```

### 📊 **Logs e Monitoramento**

#### **Debug Logs**
```dart
// Habilite logs detalhados no app_config.dart
static bool debugLogs = true;

// Use em todo o código:
if (AppConfig.debugLogs) {
  print('Debug: $message');
}
```

#### **Performance Monitoring**
```bash
# Análise de performance
flutter run --profile

# Memory usage
flutter run --track-widget-creation
```

---

## 🚀 Deploy e Distribuição

### 📦 **Build para Produção**

#### **Android (Play Store)**
```bash
# Gerar App Bundle (recomendado)
flutter build appbundle --release

# Gerar APK
flutter build apk --release --split-per-abi
```

#### **iOS (App Store)**
```bash
# Build para iOS (macOS necessário)
flutter build ios --release

# Archive no Xcode
open ios/Runner.xcworkspace
```

#### **Web (Hospedagem)**
```bash
# Build para web
flutter build web --release

# Deploy para Firebase Hosting
firebase deploy --only hosting
```

### 🌐 **Configuração de Produção**

#### **Ambiente de Produção (.env.prod)**
```env
API_URL=https://api.conectar.com
CONNECTION_TIMEOUT=30
RECEIVE_TIMEOUT=30
DEBUG_LOGS=false
```

#### **CI/CD Pipeline Example (GitHub Actions)**
```yaml
name: Flutter CI/CD
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      - run: flutter build web --release
```

---

## 👥 Contribuição e Desenvolvimento

### 📋 **Guidelines de Contribuição**

#### **Code Style**
- Siga as convenções do Dart/Flutter
- Use `flutter analyze` antes de commits
- Mantenha cobertura de testes > 80%

#### **Commit Messages**
```bash
feat: adiciona autenticação Google
fix: corrige bug na listagem de usuários
docs: atualiza documentação da API
test: adiciona testes para UserController
```

#### **Pull Requests**
1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'feat: adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

### 🔧 **Setup de Desenvolvimento**

#### **Ferramentas Recomendadas**
- **IDE**: Visual Studio Code + Flutter Extension
- **Debugger**: Flutter Inspector
- **State Management**: Provider DevTools
- **API Testing**: Postman ou Insomnia

#### **Extensions VS Code**
```json
{
  "recommendations": [
    "dart-code.flutter",
    "dart-code.dart-code",
    "ms-vscode.vscode-json",
    "bradlc.vscode-tailwindcss"
  ]
}
```

---

## 📚 Recursos Adicionais

### 🔗 **Links Úteis**

- [📖 Documentação Flutter](https://docs.flutter.dev/)
- [🎯 Provider Pattern](https://pub.dev/packages/provider)
- [🌐 GoRouter](https://pub.dev/packages/go_router)
- [🔥 Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)
- [🧪 Testing Flutter Apps](https://docs.flutter.dev/testing)

### 📖 **Documentação do Backend**

- API Swagger: `http://localhost:3000/api`
- Repositório Backend: [Conectar-NestJS-Test-server](https://github.com/wesleytakatsu/Conectar-NestJS-Test-server)

### 🎓 **Material de Referência**

- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)
- [Provider Best Practices](https://pub.dev/packages/provider#best-practices)
- [Flutter Testing Guide](https://flutter.dev/docs/testing)

---

## 📄 Licença

Este projeto foi desenvolvido como parte de um teste técnico para a empresa **Conéctar**.

**Desenvolvido com ❤️ usando Flutter**

---

## 📞 Suporte

Para dúvidas ou problemas:

1. **Issues**: Abra uma issue no GitHub
2. **Documentação**: Consulte este README
3. **Testes**: Execute `flutter test` para verificar integridade
4. **Logs**: Verifique os logs de debug no console

---

<div align="center">

**⭐ Se este projeto foi útil, considere dar uma estrela no repositório!**

[![Flutter](https://img.shields.io/badge/Made%20with-Flutter-blue?logo=flutter)](https://flutter.dev/)
[![Provider](https://img.shields.io/badge/State-Provider-green)](https://pub.dev/packages/provider)
[![Tests](https://img.shields.io/badge/Tests-Passing-brightgreen)](./test/)

</div>
