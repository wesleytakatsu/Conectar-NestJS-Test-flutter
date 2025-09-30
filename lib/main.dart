import 'package:conectar_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'routes/app_routes.dart';
import 'controllers/auth_controller.dart';
import 'controllers/users_controller.dart';
import 'controllers/company_controller.dart';
import 'services/company_service.dart';
import 'config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar configuração do app
  try {
    await AppConfig.initialize();
  } catch (e) {
    // Erro ao carregar configuração, usar padrões
  }

  // Inicializar Firebase com tratamento de erro para plataformas desktop
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Firebase não pôde ser inicializado
    // O app funcionará sem funcionalidades do Firebase
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => UsersController()),
        ChangeNotifierProvider(
          create: (context) {
            final authController = context.read<AuthController>();
            final companyService = CompanyService(authController.authService.dio);
            return CompanyController(companyService);
          },
        ),
      ],
      child: Consumer<AuthController>(
        builder: (context, authController, child) {
          final router = GoRouter(
            routes: AppRoutes.routes,
            initialLocation: authController.isLoggedIn ? '/home' : '/login',
            redirect: (context, state) {
              final isLoggedIn = authController.isLoggedIn;
              final isLoginRoute = state.matchedLocation == '/login';
              final isRegisterRoute = state.matchedLocation == '/register';

              if (!isLoggedIn && !isLoginRoute && !isRegisterRoute) {
                return '/login';
              }
              if (isLoggedIn && (isLoginRoute || isRegisterRoute)) {
                return '/home';
              }
              return null;
            },
          );

          return MaterialApp.router(
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
            title: 'Conectar App',
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
          );
        },
      ),
    );
  }
}
