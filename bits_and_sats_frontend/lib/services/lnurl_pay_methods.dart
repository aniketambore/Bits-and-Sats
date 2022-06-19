@JS()
library lnurl_pay;

import 'package:js/js.dart';

@JS()
external pay(String walletAddress, String comment, num tokens);
