import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/app.dart';
import 'package:flutter_base_template/foundation/constants.dart';
import 'package:flutter_base_template/foundation/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Display Toast (Only Dev)
  if (Constants.flavor == Flavor.dev) {
    Fluttertoast.showToast(
      msg: "flavor: ${EnumToString.convertToString(Constants.flavor)}",
    );
  }

  runZonedGuarded(() {
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stackTrace) {
    logger.e('(( Error )) => ', error: error, stackTrace: stackTrace);
  });
}
