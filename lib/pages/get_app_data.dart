import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';

class GetHealthDataFromApp extends StatefulWidget {
  const GetHealthDataFromApp({super.key});

  @override
  State<GetHealthDataFromApp> createState() => _GetHealthDataFromAppState();
}

class _GetHealthDataFromAppState extends State<GetHealthDataFromApp> {
  bool readOnly = true;
  String resultText = '';
  String token = "";

  List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
  ];

  bool get _isHealthConnectSupportedPlatform => !kIsWeb && Platform.isAndroid;

  Future<void> _runHealthConnectAction(Future<String> Function() action) async {
    if (!_isHealthConnectSupportedPlatform) {
      resultText = 'Health Connect is supported only on Android devices.';
      _updateResultText();
      return;
    }

    try {
      resultText = await action();
    } on MissingPluginException {
      resultText =
          'Health Connect plugin is not registered. Do a full app restart and run on Android.';
    } on PlatformException catch (e) {
      resultText = 'Platform error: ${e.message ?? e.code}';
    } catch (e) {
      resultText = e.toString();
    }

    _updateResultText();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Connect'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => _runHealthConnectAction(() async {
              final result = await HealthConnectFactory.isApiSupported();
              return 'isApiSupported: $result';
            }),
            child: const Text('isApiSupported'),
          ),
          ElevatedButton(
            onPressed: () => _runHealthConnectAction(() async {
              final result = await HealthConnectFactory.isAvailable();
              return 'isAvailable: $result';
            }),
            child: const Text('Check installed'),
          ),
          ElevatedButton(
            onPressed: () => _runHealthConnectAction(() async {
              await HealthConnectFactory.installHealthConnect();
              return 'Install activity started';
            }),
            child: const Text('Install Health Connect'),
          ),
          ElevatedButton(
            onPressed: () => _runHealthConnectAction(() async {
              await HealthConnectFactory.openHealthConnectSettings();
              return 'Settings activity started';
            }),
            child: const Text('Open Health Connect Settings'),
          ),
          ElevatedButton(
            onPressed: () => _runHealthConnectAction(() async {
              final result = await HealthConnectFactory.hasPermissions(
                types,
                readOnly: readOnly,
              );
              return 'hasPermissions: $result';
            }),
            child: const Text('Has Permissions'),
          ),
          ElevatedButton(
            onPressed: () => _runHealthConnectAction(() async {
              token = await HealthConnectFactory.getChangesToken(types);
              return 'token: $token';
            }),
            child: const Text('Get Changes Token'),
          ),
          ElevatedButton(
            onPressed: () => _runHealthConnectAction(() async {
              final result = await HealthConnectFactory.getChanges(token);
              return 'token: $result';
            }),
            child: const Text('Get Changes'),
          ),
          ElevatedButton(
            onPressed: () => _runHealthConnectAction(() async {
              final result = await HealthConnectFactory.requestPermissions(
                types,
                readOnly: readOnly,
              );
              return 'requestPermissions: $result';
            }),
            child: const Text('Request Permissions'),
          ),
          ElevatedButton(
            onPressed: () => _runHealthConnectAction(() async {
              final startTime = DateTime.now().subtract(const Duration(days: 4));
              final endTime = DateTime.now();
              final requests = <Future>[];
              final Map<String, dynamic> typePoints = {};
              for (final type in types) {
                requests.add(
                  HealthConnectFactory.getRecord(
                    type: type,
                    startTime: startTime,
                    endTime: endTime,
                  ).then((value) => typePoints.addAll({type.name: value})),
                );
              }
              await Future.wait(requests);
              return '$typePoints';
            }),
            child: const Text('Get Record'),
          ),
          Text(resultText),
        ],
      ),
    );
  }

  void _updateResultText() {
    setState(() {});
  }
}
