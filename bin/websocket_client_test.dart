import 'dart:io' show WebSocket;
import 'dart:convert' show json;
import 'dart:async' show Timer;

main() async {
  // int _connections = 1000;

  // for (var i = 0; i < _connections; i++) {
  //   await _connect(i);
  // }

  await _connect(1);
}

Future<void> _connect(int i) async {
  await WebSocket.connect(
    'ws://0.0.0.0:8080/getNotificaion',
    headers: {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTYzOTgyNzc2Mjg5MSwiZW1haWwiOiJ0ZXN0QGdtYWlsLmNvbSIsImlhdCI6MTYzOTgyNzc2Mn0.7ZNuyFjHw7HQvnT6s0tVIrEdCO0XcTAZtcJLut99QkY',
      'email': 'test@gmail.com',
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
