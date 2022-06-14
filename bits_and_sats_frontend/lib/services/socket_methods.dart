import 'socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit("createRoom", {"nickname": nickname});
    } else {
      print("[+] Nickname cannot be empty bro :(");
    }
  }
}
