import 'package:go_router/go_router.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';
import '../views/home_view.dart';
import '../views/users_list_view.dart';
import '../views/companies_list_view.dart';
import '../views/user_form_view.dart';
import '../views/user_edit_view.dart';
import '../views/profile_view.dart';
import '../views/navbar_test_view.dart';
import '../views/company_register_view.dart';
import '../views/company_edit_view.dart';

class AppRoutes {
  static final routes = [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => const UsersListView(),
    ),
    GoRoute(
      path: '/companies',
      builder: (context, state) => const CompaniesListView(),
    ),
    GoRoute(
      path: '/user-form',
      builder: (context, state) => const UserFormView(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: '/navbar-test',
      builder: (context, state) => const NavbarOnlyTestView(),
    ),
    GoRoute(
      path: '/company-register',
      builder: (context, state) => const CompanyRegisterView(),
    ),
    GoRoute(
      path: '/company-edit/:id',
      builder: (context, state) {
        final companyId = state.pathParameters['id']!;
        return CompanyEditView(companyId: companyId);
      },
    ),
    GoRoute(
      path: '/user-edit/:id',
      builder: (context, state) {
        final userId = state.pathParameters['id']!;
        return UserEditView(userId: userId);
      },
    ),
  ];
}