import 'dart:developer';

import 'package:cart_storage_api/local_storage_api.dart';
import 'package:cart_storage_repository/cart_storage_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:lichi_app/app/app.dart';
import 'package:lichi_app/app/app_bloc_observer.dart';
import 'package:lichi_app/core/database/drift_db.dart';
import 'package:path_provider/path_provider.dart';

Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };

  Bloc.observer = const AppBlocObserver();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  final AppDatabase db = AppDatabase();
  final localStorageApi = LocalStorageApi(db: db);

  runApp(
    LichiApp(
      createStorageRepository: () =>
          CartStorageRepository(storageApi: localStorageApi),
    ),
  );
}
