import 'package:provider/provider.dart';

import 'dark_mode_provider.dart';
import 'user_provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices
];

///独立的Provider
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<DarkModeProvider>(
    builder: (context) => DarkModeProvider(),
  ),
  ChangeNotifierProvider<UserProvider>(
    builder: (context) => UserProvider(),
  )
];
