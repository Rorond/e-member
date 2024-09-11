import 'dart:async';
import 'dart:convert';

import 'package:emembers/data/web_client.dart';
import 'package:local_auth/local_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:emembers/constants.dart';
import './guid.dart';
import '../models/user.dart';

class AuthModel extends Model {
  final Uri loginurl = Uri.parse(Constants.apiGateway + '/Guest/Login');
  final Uri registerurl = Uri.parse(Constants.apiGateway + '/Guest/Register');

  String errorMessage = '';
  dynamic errorMsg = [];

  bool _rememberMe = false;
  bool _stayLoggedIn = true;
  bool _useBio = false;
  User _user = User();

  bool get rememberMe => _rememberMe;

  void handleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("remember_me", value);
    });
  }

  bool get isBioSetup => _useBio;

  void handleIsBioSetup(bool value) {
    _useBio = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("use_bio", value);
    });
  }

  bool get stayLoggedIn => _stayLoggedIn;

  void handleStayLoggedIn(bool value) {
    _stayLoggedIn = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("stay_logged_in", value);
    });
  }

  void loadSettings() async {
    var _prefs = await SharedPreferences.getInstance();
    try {
      _useBio = _prefs.getBool("use_bio") ?? false;
    } catch (e) {
      print(e);
      _useBio = false;
    }
    try {
      _rememberMe = _prefs.getBool("remember_me") ?? false;
    } catch (e) {
      print(e);
      _rememberMe = false;
    }
    try {
      _stayLoggedIn = _prefs.getBool("stay_logged_in") ?? false;
    } catch (e) {
      print(e);
      _stayLoggedIn = false;
    }

    if (_stayLoggedIn) {
      User _savedUser = User();
      try {
        String? _saved = _prefs.getString("user_data");
        print("Saved: $_saved");
        _savedUser = User.fromJson(json.decode(_saved!));
      } catch (e) {
        print("User Not Found: $e");
      }
      if (_useBio) {
        if (await biometrics()) {
          _user = _savedUser;
        }
      } else {
        _user = _savedUser;
      }
    }
    notifyListeners();
  }

  Future<bool> biometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options:
            AuthenticationOptions(useErrorDialogs: true, stickyAuth: false),
      );
    } catch (e) {
      print(e);
    }
    return authenticated;
  }

  User get user => _user;

  Future<User?> getInfo(String token, String username, String password) async {
    var responseJson;
    try {
      //var _data = await WebClient(User(token: token)).get(apiURL);
      var _data = await WebClient(User(token: token))
          .post(loginurl, {"EmailAddress": username, "Password": password});
      //var _json = json.decode(json.encode(_data));
      responseJson = json.decode(_data);

      var dataset = responseJson["entity"];
      var _newUser = User.fromJson(dataset);

      Uri memberURLDetail = Uri.parse(Constants.apiGateway +
          "/Guest/GetDetail?Id=" +
          _newUser.userId.toString());
      var _token = _newUser.token;
      var datasetDetail;
      var responseDetail =
          await WebClient(User(token: _token)).get(memberURLDetail);
      bool responseData = responseDetail == null ? false : true;
      if (responseDetail["returnStatus"] == true && responseData == true) {
        datasetDetail = responseDetail["entity"];
        _newUser = new User.fromJson(datasetDetail);
        _newUser.token = dataset["token"].toString();
        // _newUser?.emailAddress = datasetDetail["emailAddress"].toString();
        // _newUser?.imageUrl = datasetDetail["imageUrl"].toString();
        // _newUser?.birthDate = datasetDetail["birthDate"].toString();
        // _newUser?.birthPlace = datasetDetail["birthPlace"].toString();
        // _newUser?.npwp = datasetDetail["npwp"].toString();
        // _newUser?.ktp = datasetDetail["ktp"].toString();
        // _newUser?.sim = datasetDetail["sim"].toString();
        // _newUser?.evCodeStatus = datasetDetail["evCodeStatus"].toString();
      }
      //_newUser?.token = dataset["token"].toString();
      return _newUser;
    } catch (e) {
      //print("Could Not Load Data: $e");
      if (responseJson == null) {
        errorMsg = "Connection Failed, Please check internet connection";
      } else {
        errorMsg = responseJson["returnMessage"].toString();
      }
      return null;
    }
  }

  Future<User?> getInfoByUserId(String token, int userId) async {
    var responseJson;
    try {
      User _newUser = User();
      Uri memberURLDetail = Uri.parse(
          Constants.apiGateway + "/Guest/GetDetail?Id=" + userId.toString());
      var datasetDetail;
      var responseDetail =
          await WebClient(User(token: token)).get(memberURLDetail);
      bool responseData = responseDetail == null ? false : true;
      if (responseDetail["returnStatus"] == true && responseData == true) {
        datasetDetail = responseDetail["entity"];
        _newUser = new User.fromJson(datasetDetail);
        _newUser.token = token;
      }
      return _newUser;
    } catch (e) {
      //print("Could Not Load Data: $e");
      if (responseJson == null) {
        errorMsg = "Connection Failed, Please check internet connection";
      } else {
        errorMsg = responseJson["returnMessage"].toString();
      }
      return null;
    }
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    //var _responseJson = json.decode(_data);
    var uuid = new GUIDGen();
    String _username = username;
    // tokenuser = _responseJson.token.toString();
    //String _password = password;

    // todo: api login
    await Future.delayed(Duration(seconds: 3));
    // print("Logging In => $_username, $_password");

    if (_rememberMe) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("saved_username", _username);
      });
    }

    // Get Info For User
    User? _newUser = await getInfo(uuid.toString(), username, password);
    if (_newUser != null) {
      _user = _newUser;
      notifyListeners();
      handleStayLoggedIn(true);
      SharedPreferences.getInstance().then((prefs) {
        var _save = json.encode(_user.toJson());
        // print("Data: $_save");
        prefs.setString("user_data", _save);
      });
    }
    if (_newUser?.token == null || _newUser!.token.isEmpty) return false;
    return true;
    // if (tokenuser == null) {
    //   return false;
    // } else {
    //   return true;
    // }
  }

  Future<bool> loginById({
    required String token,
    required int userid,
  }) async {
    int _userid = userid;
    String _token = token;

    // todo: api login
    await Future.delayed(Duration(seconds: 3));

    // Get Info For User
    User? _newUser = await getInfoByUserId(_token, _userid);
    if (_newUser != null) {
      _user = _newUser;
      notifyListeners();
      handleStayLoggedIn(true);
      SharedPreferences.getInstance().then((prefs) {
        var _save = json.encode(_user.toJson());
        // print("Data: $_save");
        prefs.setString("user_data", _save);
      });
    }

    if (_newUser?.token == null || _newUser!.token.isEmpty) return false;
    return true;
  }

  Future<bool> register({
    required String username,
    required String phone,
    required String password,
    required String firstname,
    required String lastname,
    required String image,
  }) async {
    //var uuid = new Uuid();
    String _username = username;
    String _phone = phone;
    String _password = password;
    String _fisrtname = firstname;
    String _lastname = lastname;
    String _image = image;
    // todo: api login
    await Future.delayed(Duration(seconds: 3));

    //var _data = await WebClient(User(token: token)).get(apiURL);
    var _data = await WebClient(User(token: '')).post(registerurl, {
      "EmailAddress": _username,
      "Password": _password,
      "FirstName": _fisrtname,
      "LastName": _lastname,
      "GuestTypeId": "1",
      "GenderId": "1",
      "ReligionId": "1",
      "BloodTypeId": "1",
      "MaritalStatusId": "1",
      "ImageBase64String": _image
    });

    User _newUser = User();
    var responseJson = json.decode(_data);
    bool responseRegister = responseJson == null ? false : true;
    if (responseJson["returnStatus"] == true && responseRegister == true) {
      var dataset = responseJson["entity"];
      _newUser = User.fromJson(dataset);
      String _token = _newUser.token;

      Uri memberEVCodeURL =
          Uri.parse(Constants.apiGateway + "/Guest/EmailVerification");
      await WebClient(User(token: _token)).post(memberEVCodeURL, _newUser);

      Uri memberURLDetail = Uri.parse(Constants.apiGateway +
          "/Guest/GetDetail?Id=" +
          _newUser.userId.toString());
      var responseDetail =
          await WebClient(User(token: _token)).get(memberURLDetail);
      bool responseData = responseDetail == null ? false : true;
      if (responseDetail["returnStatus"] == true && responseData == true) {
        var datasetDetail = responseDetail["entity"];
        _newUser = new User.fromJson(datasetDetail);
      }

      Uri uriComm = Uri.parse(Constants.apiGateway +
          '/GuestCommunication/InquiryByGuestId' +
          "?GuestId=" +
          _newUser.userId.toString());
      var responseComm = await WebClient(User(token: _token)).get(uriComm);
      bool responseDataComm = responseComm == null ? false : true;
      if (responseComm["entity"].toString().isEmpty == true &&
          responseDataComm == true) {
        Uri uriCommCreate =
            Uri.parse(Constants.apiGateway + '/GuestCommunication/Create');
        await WebClient(User(token: _token)).post(uriCommCreate, {
          "GuestId": user.userId,
          "Type": "Handphone",
          "ContactNo": phone,
        });
      }
    } else {
      if (responseJson == null) {
        errorMsg = "Connection Failed, Please check internet connection";
      } else {
        errorMsg = responseJson["returnMessage"].toString();
      }
    }
    _user = _newUser;
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      var _save = json.encode(_user.toJson());
      print("Data: $_save");
      prefs.setString("user_data", _save);
    });

    if (_newUser.token.isEmpty) return false;
    return true;
  }

  Future firebaseToken(String token, String ftoken, int id) async {
    //var responseJson;
    final Uri firebaseGetTokenUrl = Uri.parse(
        Constants.apiGateway + "/Guest/GetFirebaseToken?Id=" + id.toString());
    final Uri firebaseUpdateTokenUrl =
        Uri.parse(Constants.apiGateway + "/Guest/UpdateFirebaseToken");
    try {
      //var _data = await WebClient(User(token: token)).get(firebaseGetTokenUrl);
      //var uri =  Constants.apiContent+"/eventnews";
      // var response = await http.get(firebaseGetTokenUrl,
      //   headers: {
      //     HttpHeaders.contentTypeHeader: 'application/json',
      //   }
      // );
      // if (response.statusCode == 200) {
      var response =
          await WebClient(User(token: token)).get(firebaseGetTokenUrl);
      //var responseJson = json.decode(response.toString());

      if (response["returnStatus"] == true ||
          response["firebaseToken"] == null) {
        //var responseJson = json.decode(response.body);
        var dataset = response["entity"];
        var _ftoken = dataset["firebaseToken"].toString();
        String msg;

        if (ftoken != _ftoken) {
          // var _updatefirebase = await WebClient(User(token: token)).post(firebaseUpdateTokenUrl,
          // { "Id": id, "firebaseToken": ftoken});
          // var responseJson = json.decode(_updatefirebase);
          var response = await WebClient(User(token: token)).post(
              firebaseUpdateTokenUrl, {"Id": id, "firebaseToken": ftoken});
          var responseJson = json.decode(response.toString());
          var dataset = responseJson["entity"];
          msg = dataset["returnMessage"].toString();
        } else {
          msg = "Last firebase token";
        }
        print(msg);
        return msg;
      }
    } catch (e) {
      //print("Could Not Load Data: $e");
      //if (responseJson == null) {
      errorMsg = "Connection Failed, Please check internet connection";
      //} else {
      //  errorMsg = responseJson["returnMessage"].toString();
      //}
      return errorMsg;
    }
  }

  Future<void> logout() async {
    _user = User();
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("user_data", "");
    });
    return;
  }
}

// class AuthModel extends Model {
//   final Uri loginurl = Uri.parse(Constants.apiGateway + "/Guest/Login");
//   final Uri registerurl = Uri.parse(Constants.apiGateway + "/Guest/Register");

//   String errorMessage = '';
//   dynamic errorMsg = [];

//   bool _rememberMe = false;
//   bool _stayLoggedIn = true;
//   bool _useBio = false;
//   User? _user;

//   bool get rememberMe => _rememberMe;

//   void handleRememberMe(bool value) {
//     _rememberMe = value;
//     notifyListeners();
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setBool("remember_me", value);
//     });
//   }

//   bool get isBioSetup => _useBio;

//   void handleIsBioSetup(bool value) {
//     _useBio = value;
//     notifyListeners();
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setBool("use_bio", value);
//     });
//   }

//   bool get stayLoggedIn => _stayLoggedIn;

//   void handleStayLoggedIn(bool value) {
//     _stayLoggedIn = value;
//     notifyListeners();
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setBool("stay_logged_in", value);
//     });
//   }

//   void loadSettings() async {
//     var _prefs = await SharedPreferences.getInstance();
//     try {
//       _useBio = _prefs.getBool("use_bio") ?? false;
//     } catch (e) {
//       print(e);
//       _useBio = false;
//     }
//     try {
//       _rememberMe = _prefs.getBool("remember_me") ?? false;
//     } catch (e) {
//       print(e);
//       _rememberMe = false;
//     }
//     try {
//       _stayLoggedIn = _prefs.getBool("stay_logged_in") ?? false;
//     } catch (e) {
//       print(e);
//       _stayLoggedIn = false;
//     }

//     if (_stayLoggedIn) {
//       User? _savedUser;
//       try {
//         String? _saved = _prefs.getString("user_data");
//         print("Saved: $_saved");
//         _savedUser = User.fromJson(json.decode(_saved!));
//       } catch (e) {
//         print("User Not Found: $e");
//       }
//       // if (_useBio) {
//       //   if (await biometrics()) {
//       //     _user = _savedUser;
//       //   }
//       // } else {
//       _user = _savedUser;
//       // }
//     }
//     notifyListeners();
//   }

//   User? get user => _user;

//   Future<User?> getInfo(String username, String password) async {
//     var responseJson;
//     // try {
//     Uri loginUrl = Uri.parse(
//         Constants.apiGateway + '/Account/Login?UserId=2&Localization=UTC+0700');

//     var response = await http.post(
//       loginUrl,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Access-Control-Allow-Origin': '*',
//         'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
//         'Access-Control-Allow-Headers':
//             'Origin, X-Requested-With, Content-Type, Accept',
//         'Access-Control-Allow-Credentials': 'true'
//       },
//       body: jsonEncode(
//           <String, String>{"EmailAddress": username, "Password": password}),
//     );
//     if (response.statusCode == 200) {
//       responseJson = json.decode(response.body.toString());
//       var _newUser = User.fromJson(responseJson);
//       return _newUser;
//     } else {
//       errorMsg = responseJson["returnMessage"].toString();
//       return null;
//     }
//     // } catch (e) {
//     //   if (responseJson == null) {
//     //     errorMsg = responseJson["returnMessage"].toString();
//     //   } else {
//     //     errorMsg = responseJson["returnMessage"].toString();
//     //   }
//     //   return null;
//     // }
//   }

//   Future<bool> login({
//     String? username,
//     String? password,
//   }) async {
//     String _username = username!;
//     String _password = password!;

//     // todo: api login
//     await Future.delayed(Duration(seconds: 3));
//     // print("Logging In => $_username, $_password");

//     if (_rememberMe) {
//       SharedPreferences.getInstance().then((prefs) {
//         prefs.setString("saved_username", _username);
//       });
//     }

//     // Get Info For User
//     User? _newUser = await getInfo(_username, _password);
//     if (_newUser != null) {
//       _user = _newUser;
//       notifyListeners();
//       handleStayLoggedIn(true);
//       SharedPreferences.getInstance().then((prefs) {
//         var _save = json.encode(_user!.toJson());
//         // print("Data: $_save");
//         prefs.setString("user_data", _save);
//       });
//     }

//     if (_newUser?.token == null || _newUser!.token.isEmpty) return false;
//     return true;
//   }

//   Future<void> logout() async {
//     _user = null;
//     notifyListeners();
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setString("user_data", "");
//     });
//     return;
//   }
// }
