import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as inner;
import 'package:path/path.dart';

// import 'package:local_auth/local_auth.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'constant.dart';
import 'package:emembers/data/models/user.dart';

class WebClient {
  WebClient(this.auth);

  User auth;

  Future<String?> getWithString(Uri url) async {
    if (auth == null) throw ('Auth Model Required');
    final String _token = auth.token == "" ? "" : auth.token;
    if (_token == "") {
      final http.Response response = await getHttpReponse(
        url,
        method: HttpMethod.get,
        headers: {},
      );
      if (response.body == null) return null;

      return response.body;
    } else {
      final http.Response response = await getHttpReponse(
        url,
        headers: {
          _token == "" ? "" : HttpHeaders.authorizationHeader: "Bearer $_token",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
        },
        method: HttpMethod.get,
      );
      if (response.body == null) return null;

      return response.body;
    }
  }

  Future<dynamic> get(Uri url) async {
    if (auth == null) throw ('Auth Model Required');
    final String _token = auth.token == "" ? "" : auth.token;
    if (_token == "") {
      final http.Response response = await getHttpReponse(
        url,
        method: HttpMethod.get,
        headers: {},
      );
      if (response == null || response.body == null) return null;

      return json.decode(response.body);
    } else {
      final http.Response response = await getHttpReponse(
        url,
        headers: {
          _token == "" ? "" : HttpHeaders.authorizationHeader: "Bearer $_token",
        },
        method: HttpMethod.get,
      );
      if (response == null || response.body == "Not Found") return null;
      if (response.headers["content-type"] == "text/html") {
        return response.body;
      }
      return json.decode(response.body);
    }
  }

  Future<dynamic> delete(Uri url) async {
    final String _token = auth.token;
    http.Response response = await getHttpReponse(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token",
      },
      method: HttpMethod.delete,
    );

    return json.decode(response.body);
  }

  Future<dynamic> post(Uri url, dynamic data) async {
    if (auth == null) throw ('Auth Model Required');
    var body = json.encode(data);
    Map<String, String> header = {};
    final String _token = auth.token;
    if (_token == '') {
      header = {
        HttpHeaders.contentTypeHeader: 'application/json',
        "x-api-key": "aTo9xDV00R5WJGbGDGs569I854y8H0fG"
      };
    } else {
      header = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        "x-api-key": "aTo9xDV00R5WJGbGDGs569I854y8H0fG"
      };
    }
    final http.Response response = await getHttpReponse(
      url,
      body: body,
      headers: header,
      method: HttpMethod.post,
    );

    if (response.headers.containsValue("json")) {
      return json.decode(response.body);
    }

    return response.body;
  }

  Future<dynamic> put(Uri url, dynamic data) async {
    final String _token = auth.token == "" ? "" : auth.token;
    var body = json.encode(data);
    final http.Response response = await getHttpReponse(
      url,
      body: body,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $_token",
      },
      method: HttpMethod.put,
    );
    if (response.headers.containsValue("json")) {
      return json.decode(response.body);
    }

    return response.body;
  }

  Future<http.StreamedResponse> uploadFile(
      String url, File file, String name) async {
    var stream = http.ByteStream(DelegatingStream(file.openRead()));
    var length = await file.length();
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    var multipartFile =
        http.MultipartFile(name, stream, length, filename: basename(file.path));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    return response;
  }

  Future<http.Response> getHttpReponse(
    Uri url, {
    dynamic body,
    required Map<String, String> headers,
    HttpMethod method = HttpMethod.get,
  }) async {
    final inner.IOClient _client = getClient();
    var response;
    try {
      switch (method) {
        case HttpMethod.post:
          response = await _client.post(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
          );
          break;
        case HttpMethod.get:
          response = await _client.get(
            url,
            headers: headers,
          );
      }

      print("URL: $url");
      print("Body: $body");
      print("Response Code: " + response.statusCode.toString());
      print("Response Body: " + response.body.toString());

      if (json.decode(response.body)['status'] == 'Token is Expired') {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("user_data", "");
        });
      }
      if (response.statusCode >= 400) {
        // if (response.statusCode == 404) return response.body; // Not Found Message
        if (response.statusCode == 401) {
          if (auth != null) {
            // Todo: Refresh Token !
            // await auth.refreshToken();
            final String _token = auth.token;
            print(" Second Token => $_token");
            // Retry Request
            response = await getHttpReponse(
              url,
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $_token",
              },
            );
          }
        } // Not Authorized
        // if (devMode) throw ('An error occurred: ' + response.body);
      }
    } catch (e) {
      print('Error with URL: $e');
    }

    return response;
  }

  inner.IOClient getClient() {
    //bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) =>
              host == "https://e-members.sinarmasland.com");
    inner.IOClient ioClient = new inner.IOClient(httpClient);
    return ioClient;
  }
}

enum HttpMethod { get, post, put, delete }
