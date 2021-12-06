import 'dart:io' show WebSocket;
import 'dart:convert' show json;
import 'dart:async' show Timer;

main() {
  WebSocket.connect('ws://0.0.0.0:8000').then((WebSocket ws) {
    // our websocket server runs on ws://0.0.0.0:8000
    if (ws.readyState == WebSocket.open) {
      // as soon as websocket is connected and ready for use, we can start talking to other end
      ws.add(json.encode({
        'data': 'from client at ${DateTime.now().toString()}',
      })); // this is the JSON data format to be transmitted
      ws.listen(
        // gives a StreamSubscription
        (data) {
          print(
              '\t\t -- ${Map<String, String>.from(json.decode(data))}'); // listen for incoming data and show when it arrives
          Timer(Duration(seconds: 1), () {
            if (ws.readyState == WebSocket.open) {
              ws.add(json.encode({
                'data': 'from client at ${DateTime.now().toString()}',
              }));
            }
          });
        },
        onDone: () => print('[+]Done :)'),
        onError: (err) => print('[!]Error -- ${err.toString()}'),
        cancelOnError: true,
      );
    } else {
      print('[!]Connection Denied');
    }
    // in case, if serer is not running now
  }, onError: (err) => print('[!]Error -- ${err.toString()}'));
}
