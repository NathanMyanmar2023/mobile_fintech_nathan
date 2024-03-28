import 'package:nathan_app/network/api_constants.dart';

extension ExtensionString on String? {
  bool isNullOrEmpty() => (this == null) || (this?.isEmpty ?? true);

  bool isNotNullOrEmpty() => (this != null) && (this?.isNotEmpty ?? false);

  bool isNull() => this == null;

  bool isNotNull() => (this != null);

  String toBearerToken() => "$bearerConstant $this";
}
