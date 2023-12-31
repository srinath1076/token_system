import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/Token.dart';

class TokenController {
  List<Token> tokens = [];
  List<List<Token>> queues = [];

  void initializeQueues() {
    queues.clear();
    for (var i = 0; i < 3; i++) {
      queues.add([]);
    }
  }

  void resetTokens() {
    tokens.clear();
    initializeQueues();
    _saveTokensToFile();
  }

  Token createToken() {
    final token = Token(
      number: _generateTokenNumber(),
      validUntil: _calculateValidUntil(),
    );
    tokens.add(token);
    _saveTokensToFile();
    return token;
  }

  String _generateTokenNumber() {
    final uuid = Uuid();
    return uuid.v4().substring(0, 8); // Generating an 8-character token number
  }

  DateTime _calculateValidUntil() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day).add(Duration(days: 1));
    return midnight.subtract(Duration(milliseconds: 1));
  }

  Future<void> _saveTokensToFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/tokens.json');
    final encodedTokens = tokens.map((token) => token.toJson()).toList();
    final jsonString = jsonEncode(encodedTokens);
    await file.writeAsString(jsonString);
  }

  // Add the following method to load tokens from file if needed
  Future<void> loadTokensFromFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/tokens.json');
    if (file.existsSync()) {
      final jsonString = await file.readAsString();
      final decodedTokens = jsonDecode(jsonString) as List<dynamic>;
      tokens = decodedTokens.map((json) => Token.fromJson(json)).toList();
    }
  }
}
