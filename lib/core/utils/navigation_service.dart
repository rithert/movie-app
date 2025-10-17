import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  // Navegación con slide desde la derecha (recomendada para app de películas)
  static Future<T?> navigateTo<T>(Widget page) async {
    return await navigatorKey.currentState?.push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Slide desde la derecha
          var slideAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Desde la derecha
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic, // Curva suave y cinematográfica
          ));

          // Animación de fade para la página anterior
          var fadeAnimation = Tween<double>(
            begin: 1.0,
            end: 0.8,
          ).animate(CurvedAnimation(
            parent: secondaryAnimation,
            curve: Curves.easeInCubic,
          ));

          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  // Método para regresar
  static void pop<T>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  // Reemplazar página actual
  static Future<T?> pushReplacement<T>(Widget page) async {
    return await navigatorKey.currentState?.pushReplacement<T, void>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var slideAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ));

          return SlideTransition(
            position: slideAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
