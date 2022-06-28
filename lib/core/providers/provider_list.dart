import 'package:gym_user/core/Kaimly/providers/authProvider.dart';
import 'package:gym_user/core/providers/membershipProvider.dart';
import 'package:gym_user/core/providers/routeProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers() {
  return [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => MembershipProvider()),
    ChangeNotifierProvider(create: (_) => RouteProvider()),
  ];
}
