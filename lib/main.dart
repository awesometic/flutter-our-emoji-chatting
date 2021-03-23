import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/authentication/service/auth_service.dart';
import 'src/authentication/service/auth_service_impl.dart';
import 'src/authentication/service/repository_service.dart';
import 'src/authentication/service/repository_service_impl.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<RepositoryService>(RepositoryServiceImpl());
  getIt.registerSingleton<AuthService>(AuthServiceImpl());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupLocator();
  runApp(MyApp());
}
