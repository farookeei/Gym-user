import 'package:flutter_dotenv/flutter_dotenv.dart';

final gymName = dotenv.env['GYM_NAME'].toString();
final gymLocation = dotenv.env['GYM_LOCATION'].toString();
final gymOwner = dotenv.env['GYM_OWNER'].toString();
final gymPhone = dotenv.env['GYM_PHONE'].toString();
final gymEmail = dotenv.env['GYM_EMAIL'].toString();
final gymUserRole = dotenv.env['GYM_USER_ROLE'].toString();
final gymId = dotenv.env['GYM_ID'].toString();
final gymRazorPayId = dotenv.env['RAZORPAY_KEY'].toString();
