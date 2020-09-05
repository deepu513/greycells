import 'dart:convert';

import 'package:greycells/networking/serializable.dart';

class Request<T> {
  final String url;
  final Serializable<T> _serializable;
  final Map<String, String> headers;

  T _body;

  Request(this.url, this._serializable, {this.headers});

  void setBody(T body) {
    _body = body;
  }

  Map<String, dynamic> toJsonMap() {
    if (_body != null)
      return _serializable.toJson(_body);
    else
      return {};
  }

  String toJsonString() => jsonEncode(toJsonMap());

}
