import 'dart:io';
import 'package:lsp/lsp.dart';

void main(List<String> args) async {
  // TODO change this
  const String rootPath = "/Users/omni/dart_issues/lsp_constructor_flow/";
  const String exampleFile = rootPath + "lib/example.dart";
  bool ok = File(exampleFile).existsSync();
  if (!ok) return;

  // TODO change this
  const String dartSdkPath = "/Users/omni/development/flutter/bin/cache/dart-sdk/";
  const String analysisPath = dartSdkPath + "bin/snapshots/analysis_server.dart.snapshot";

  final lspConnectorDart = LspConnectorDart(
    analysisServerPath: analysisPath,
    clientId: "example-client",
    clientVersion: "0.0.1",
  );
  final lsp = await LspSurface.start(
    lspConnector: lspConnectorDart,
    rootPath: rootPath,
    clientCapabilities: {},
  );

  final response = await lsp.textDocument_definition(
    filePath: exampleFile,
    // points to "MyClass()" in example.dart
    line: 1,
    character: 14,
  );
  final start = response.fileLocations.first.range.start;
  final end = response.fileLocations.first.range.end;

  print(start.character);
  print(end.character);
}
