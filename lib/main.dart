//import 'package:flutter/material.dart';
import 'controllers/TokenController.dart';
import 'controllers/StatsController.dart';

void main() {
  //runApp(MyApp());
  TokenController tokenController = TokenController();
  final statsController = StatsController(tokenController);

  final totalTokensIssued = statsController.getTotalTokensIssued();
  final totalTokensPending = statsController.getTotalTokensPending();
  final totalTokensCollected = statsController.getTotalTokensCollected();
  final averageWaitTime = statsController.getAverageWaitTime();
  final formattedAverageWaitTime =
      statsController.formatAverageWaitTime(averageWaitTime);

  print('Total Tokens Issued: $totalTokensIssued');
  print('Total Tokens Pending: $totalTokensPending');
  print('Total Tokens Collected: $totalTokensCollected');
  print('Average Wait Time: $formattedAverageWaitTime');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First Flutter App'),
        ),
        body: Center(
          child: Text('Hello, world!'),
        ),
      ),
    );
  }
}
