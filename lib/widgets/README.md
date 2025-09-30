# Widgets Structure - Conectar App

## Estrutura Organizacional dos Widgets

Este projeto foi refatorado para seguir as melhores práticas do Flutter, separando os widgets em componentes reutilizáveis e organizados por funcionalidade.

### 📁 Estrutura de Pastas

```
lib/widgets/
├── widgets.dart              # Arquivo de exportação principal
├── buttons/                  # Componentes de botões
│   ├── primary_button.dart   
│   └── secondary_button.dart 
├── cards/                    # Componentes de cards
│   ├── filter_card.dart      
│   └── login_card.dart       
├── common/                   # Componentes comuns/genéricos
│   ├── conectar_logo.dart    
│   ├── conecta_plus_chip.dart
│   └── status_chip.dart      
├── forms/                    # Componentes de formulário
│   ├── custom_dropdown.dart  
│   ├── custom_text_field.dart
│   ├── login_form.dart       
│   └── search_text_field.dart
├── navigation/               # Componentes de navegação
│   ├── conectar_app_bar.dart 
│   └── custom_tab_bar.dart   
└── tables/                   # Componentes de tabelas
    └── clients_table.dart    
```

### 🧱 Componentes Principais

#### Buttons
- **PrimaryButton**: Botão principal do aplicativo com estilo padrão
- **SecondaryButton**: Botão secundário com borda

#### Cards
- **FilterCard**: Card de filtros com funcionalidade de expandir/recolher
- **LoginCard**: Card container para o formulário de login

#### Common
- **ConectarLogo**: Logo texto do aplicativo
- **ConectaPlusChip**: Chip indicador do status Conecta Plus
- **StatusChip**: Chip indicador de status (Ativo/Inativo)

#### Forms
- **CustomTextField**: Campo de texto customizado com label
- **CustomDropdown**: Dropdown customizado
- **LoginForm**: Formulário completo de login
- **SearchTextField**: Campo de busca com ícone

#### Navigation
- **ConectarAppBar**: AppBar customizada do aplicativo
- **CustomTabBar**: Barra de abas customizada

#### Tables
- **ClientsTable**: Tabela completa de clientes com DataTable2

### 🔄 Como Usar

#### Importação Simples
```dart
import '../widgets/widgets.dart';
```

#### Exemplos de Uso

**Botão Principal:**
```dart
PrimaryButton(
  text: 'Ver Clientes',
  icon: Icons.people,
  onPressed: () => context.go('/users'),
)
```

**Campo de Texto:**
```dart
CustomTextField(
  label: 'Email',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  validator: (value) => value?.isEmpty == true ? 'Campo obrigatório' : null,
)
```

**Card de Filtros:**
```dart
FilterCard(
  nameController: nameController,
  cnpjController: cnpjController,
  selectedStatus: selectedStatus,
  onStatusChanged: (value) => setState(() => selectedStatus = value),
  onFilter: _onFilter,
  onClear: _onClear,
)
```

### 🎨 Padrão de Design

Todos os widgets seguem o padrão de cores do aplicativo:
- **Verde Principal**: `Color(0xFF00B050)`
- **Verde de Fundo**: `Color(0xFF2ecc71)`
- **Cores de Status**: Verde/Vermelho para Ativo/Inativo

### 📋 Views Refatoradas

As seguintes views foram completamente refatoradas:

1. **LoginView** - Agora usa `ConectarLogo` e `LoginCard`
2. **HomeView** - Usa `ConectarAppBar` e `PrimaryButton`
3. **UsersListView** - Usa `FilterCard`, `ClientsTable`, `CustomTabBar`

### 🔧 Benefícios da Refatoração

- **Reutilização**: Widgets podem ser usados em qualquer parte do app
- **Manutenibilidade**: Mudanças centralizadas em um local
- **Consistência**: Design system unificado
- **Testabilidade**: Widgets isolados são mais fáceis de testar
- **Legibilidade**: Código das views mais limpo e focado na lógica

### 🚀 Próximos Passos

Para expandir esta estrutura:

1. Adicione novos widgets em suas respectivas pastas
2. Exporte-os no arquivo `widgets.dart`
3. Documente seu uso neste README
4. Considere criar testes unitários para widgets complexos

---

**Nota**: Esta estrutura segue as recomendações da comunidade Flutter e facilita a escalabilidade do projeto.