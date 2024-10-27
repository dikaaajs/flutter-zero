import 'package:go_router/go_router.dart';
import 'package:zero/pages/home.dart';
import 'package:zero/pages/login.dart';
import 'package:zero/pages/notepage.dart';
import 'package:zero/pages/upload.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Homepage(),
    ),
    GoRoute(
      path: '/upload',
      builder: (context, state) => const UploadNote(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/note/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return Notepage(id: id);
      },
    ),
  ],
);
