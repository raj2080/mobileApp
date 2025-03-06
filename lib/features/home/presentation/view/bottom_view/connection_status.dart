import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common/internet_connectivity.dart';

class ConnectionStatus extends ConsumerStatefulWidget {
  const ConnectionStatus({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends ConsumerState<ConnectionStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 170, 119, 180), title: const Text('Connection Status')),
      body: Center(
        child: Consumer(
          builder: (context, watch, child) {
            final connectionStatus = ref.watch(connectivityStatusProvider);
            return Text(
              connectionStatus == ConnectivityStatus.isConnected ? 'Connected' : 'Disconnected',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
