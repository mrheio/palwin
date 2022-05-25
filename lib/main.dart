import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

// class Logger extends ProviderObserver {
//   @override
//   void didUpdateProvider(
//     ProviderBase provider,
//     Object? previousValue,
//     Object? newValue,
//     ProviderContainer container,
//   ) {
//     print('''
// {
//   "provider": "${provider.name ?? provider.runtimeType}",
//   "newValue": "$newValue"
// }''');
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: App()));
}
