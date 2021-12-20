import 'dart:io' show WebSocket;
import 'dart:convert' show json;
import 'dart:async' show Timer;

main() async => await _connect();

Future<void> _connect() async {
  await WebSocket.connect(
    'ws://192.168.1.200:8080/getNotificaion',
    headers: {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTY0MDAwNDE2MjAwNSwiZW1haWwiOiJ0ZXN0MkBnbWFpbC5jb20iLCJpYXQiOjE2NDAwMDQxNjJ9.MkM4cJ8Ay3OgNGoZzZX-8EGkt1SV-ZkZC5LJlLwWrJc',
      'email': 'test2@gmail.com',
    },
  ).then((WebSocket ws) {
    if (ws.readyState == WebSocket.open) {
      // int _clientID = DateTime.now().millisecondsSinceEpoch;
      // String _message = 'Client ($_clientID): Hello, server!';
      // ws.add(_message);
      ws.listen(
        (data) {
          print(data);
          // Timer(Duration(seconds: 3), () {
          //   if (ws.readyState == WebSocket.open) {
          //     ws.add(_message);
          //   }
          // });
        },
        onDone: () => print('[+]Done :)'),
        onError: (err) => print('[!]Error -- ${err.toString()}'),
        cancelOnError: true,
      );
    } else {
      print('[!]Connection Denied');
    }
  }, onError: (err) => print('[!]Error -- ${err.toString()}'));
}
