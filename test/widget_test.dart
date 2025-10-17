import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_movie/main.dart';

void main() {
  testWidgets('App de películas se carga correctamente',
      (WidgetTester tester) async {
    // Construir la app
    await tester.pumpWidget(const MainApp());

    expect(find.byType(MaterialApp), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
  });

  testWidgets('Pantalla principal muestra elementos básicos',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    final scaffold = find.byType(Scaffold);
    expect(scaffold, findsAtLeastNWidgets(1));
  });
}
