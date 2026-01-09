import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/core/utils/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LiveBtcPricePage extends StatefulWidget {
  const LiveBtcPricePage({super.key});

  @override
  State<LiveBtcPricePage> createState() => _LiveBtcPricePageState();
}

class _LiveBtcPricePageState extends State<LiveBtcPricePage> {
  late WebSocketChannel _channel;
  double _price = 0.0;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  void _connectSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade'),
    );

    _isConnected = true;

    _channel.stream.listen(
      (event) {
        AppLogger.debug('Received data: $event', 'WebSocket');
        final data = jsonDecode(event);
        setState(() {
          _price = double.parse(data['p']);
        });
      },
      onError: (error) {
        debugPrint('Socket Error: $error');
        _reconnect();
      },
      onDone: () {
        debugPrint('Socket Closed');
        _reconnect();
      },
    );
  }

  void _reconnect() {
    if (!mounted) return;

    setState(() {
      _isConnected = false;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _connectSocket();
      }
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BTC Live Price'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isConnected ? 'Connected 🟢' : 'Disconnected 🔴',
              style: TextStyle(
                color: _isConnected ? Colors.green : Colors.red,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '\$ ${_price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Future<void> test() async {
  runApp(const MaterialApp(
    home: LiveBtcPricePage(),
  ));
}