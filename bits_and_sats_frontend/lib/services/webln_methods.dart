@JS()
library webln_connection;

import 'dart:convert';

import 'package:js/js.dart';

// A reference to window.webln;
@JS()
external get webln;

@JS("JSON.stringify")
external String stringify(Object obj);

class WeblnMethods {
  Future<Map<String, dynamic>> checkWebln() async {
    final todayRecipes = await _checkWebln();
    return todayRecipes;
  }

  Future<Map<String, dynamic>> _checkWebln() async {
    final weblnValue = await webln;
    print("[+] _weblnValue is ${stringify(weblnValue)}");
    final Map<String, dynamic> json = jsonDecode(stringify(weblnValue));
    if (json.isNotEmpty) {
      return json;
    } else {
      return {};
    }
  }
}
