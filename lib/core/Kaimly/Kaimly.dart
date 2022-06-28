import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gym_user/core/Kaimly/database/AuthDatabse.dart';
import 'package:gym_user/core/Kaimly/database/UserDatabase.dart';
import 'package:gym_user/core/Kaimly/dioService.dart';
import 'package:gym_user/core/Kaimly/httpException.dart';
import 'package:gym_user/core/Kaimly/modal/auth_model.dart';
import 'package:gym_user/core/Kaimly/modal/user_model.dart';

class Kaimly {
  static Kaimly server = new Kaimly(baseUrl: '');
  static bool isLoggedIn = false;

  String? baseUrl;
  DioServicesAPI? dioServicesAPI;

  static init({required String baseUrl}) {
    server = new Kaimly(baseUrl: baseUrl);
  }

  Kaimly({required String baseUrl}) {
    this.baseUrl = baseUrl;
    dioServicesAPI = DioServicesAPI(
        baseOptions: new BaseOptions(
      baseUrl: baseUrl,
      followRedirects: false,
      validateStatus: (status) => true,
      receiveDataWhenStatusError: true,
    ));
  }

  Future<void> login(
      {required String email,
      required String password,
      String role = '',
      bool onlyThisRole = false}) async {
    try {
      Map<String, dynamic> _body = {'email': email, 'password': password};
      print(_body);
      Map _fetchData =
          await dioServicesAPI!.postAPI(url: 'auth/login', body: _body);
      final AuthModel _auth = new AuthModel(
        access_token: _fetchData['data']['access_token'],
        expires: _fetchData['data']['expires'],
        refresh_token: _fetchData['data']['refresh_token'],
      );
      await this.me(auth_: _auth, role: role, onlyThisRole: onlyThisRole);
    } catch (e) {
      throw e;
    }
  }

  Future<void> createUser(
      {required String email, required String password}) async {
    Map<String, dynamic> _body = {
      "email": email,
      "password": password,
      "role": dotenv.env['GYM_USER_ROLE'].toString()
    };
    try {
      print("checking");
      dynamic _fetchData =
          await dioServicesAPI!.postAPI(url: "users", body: _body);
      print(_fetchData);

      if (_fetchData['errors'][0]["message"] ==
          "Field \"email\" has to be unique.")
        throw HttpException(401,
            message: 'Account with this email already exists');
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<UserModel> me(
      {required AuthModel auth_,
      String role = '',
      bool onlyThisRole = false}) async {
    try {
      Map _fetchData = await dioServicesAPI!.getAPI(
          url: 'users/me?fields=id,role,*.*',
          authorization: 'Bearer ${auth_.access_token}');
      final UserModel _userModel = UserModel.convert(_fetchData);
      if (_userModel.role != role && onlyThisRole) {
        throw Exception("User not found");
      }
      UserDatabase().addData(_userModel);
      AuthDatabase().addData(auth_);
      isLoggedIn = true;
      return _userModel;
    } catch (e) {
      throw e;
    }
  }

  UserModel getMe() {
    UserModel _user = new UserModel(
        id: '',
        first_name: '',
        last_name: '',
        email: '',
        role: '',
        description: '',
        title: '',
        avatar: '');
    if (UserDatabase().acessData() == null) {
      // throw "User not logged in";
      return _user;
    } else {
      _user = UserDatabase().acessData()!;
    }

    return _user;
  }

  AuthModel auth() {
    AuthModel _auth =
        new AuthModel(access_token: "", expires: 0, refresh_token: "");
    if (AuthDatabase().acessData() == null) {
      // throw "User not logged in";
      return _auth;
    }

    _auth = (AuthDatabase().acessData())!;

    isLoggedIn = true;
    return _auth;
  }

  Future<void> logout() async {
    try {
      AuthModel? _auth = AuthDatabase().acessData();
      Map<String, dynamic> _body = {
        'refresh_token': _auth!.refresh_token.toString()
      };
      String accessToken = _auth.access_token.toString();
      AuthDatabase().deleteData();
      UserDatabase().deleteData();
      await dioServicesAPI!.postAPINoBody(
          url: 'auth/logout',
          body: _body,
          authorization: 'Bearer $accessToken');
    } catch (e) {
      throw e;
    }
  }

  items(
      {required String collection,
      String? id,
      String fields = 'fields=*.*',
      String filter = 'filter',
      String sort = 'sort'}) async {
    String url = '${server.baseUrl}items/$collection';
    if (id != null) {
      url += '/' + id;
    }
    url = '$url?$fields&$filter&$sort';

    final response = await dioServicesAPI!.getAPI(
      url: url,
      authorization: 'Bearer ${this.auth().access_token}',
    );

    print(url);

    return response;
  }

  createitem(
      {required String collection,
      String? id,
      String fields = 'fields=*.*',
      String filter = 'filter',
      String sort = 'sort',
      Map<String, dynamic> body = const {}}) async {
    String url = '${server.baseUrl}items/$collection';
    if (id != null) {
      url += '/' + id;
    }
    url = '$url?$fields&$filter&$sort';

    final response = await dioServicesAPI!.postAPI(
      url: url,
      body: body,
      authorization: 'Bearer ${this.auth().access_token}',
    );

    print(response);

    return response;
  }

  updateitem(
      {required String collection,
      String? id,
      String fields = 'fields=*.*',
      String filter = 'filter',
      String sort = 'sort',
      Map<String, dynamic> body = const {}}) async {
    String url = '${server.baseUrl}items/$collection';
    if (id != null) {
      url += '/' + id;
    }
    url = '$url?$fields&$filter&$sort';

    final response = await dioServicesAPI!.patchAPI(
      url: url,
      body: body,
      authorization: 'Bearer ${this.auth().access_token}',
    );

    // print(url);
    // print(body);
    // print(id);
    // print(response);

    return response;
  }

  Future<List<UserModel>> users(
      {String filter = "filter",
      String fields = 'fields=id,role,avatar,*.*'}) async {
    try {
      Map _fetchData = await dioServicesAPI!.getAPI(
          url: 'users?$filter&$fields',
          authorization: 'Bearer ${this.auth().access_token}');
      // print(_fetchData);
      final List<UserModel> _userModel = UserModel.convertlist(_fetchData);

      return _userModel;
    } catch (e) {
      throw e;
    }
  }

  String getFileUrl(
      {required String fileId,
      bool thumnail = false,
      int width = 100,
      int height = 100}) {
    if (thumnail) {
      return '${this.baseUrl}assets/$fileId?fit=cover&width=$width&height=$height&quality=100';
    }
    return '${this.baseUrl}assets/$fileId';
  }

  customPostAPI(
      {required String route, Map<String, dynamic> body = const {}}) async {
    String url = '${server.baseUrl}$route';

    final response = await dioServicesAPI!.postAPI(
      url: url,
      body: body,
      authorization: 'Bearer ${this.auth().access_token}',
    );

    print(response);

    return response;
  }
}
