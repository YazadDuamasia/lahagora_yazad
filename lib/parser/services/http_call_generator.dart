import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../utlis/utlis.dart';

class HttpCallGenerator {
  static Future getApiCall({
    required String? url,
    required String? header,
  }) async {
    try {
      Uri uri = Uri.parse(url ?? "");
      Map<String, String>? headerMap =
          Map<String, String>.from(convert.json.decode(header!));

      http.Response? response = await http
          .get(
            uri,
            headers: headerMap,
          )
          .timeout(const Duration(seconds: 15),
              onTimeout: () => throw TimeoutException(
                  "The connection has timed out, Please try again!"));

      if (response.statusCode == 429) {
        //server is busy.
        await getApiCall(url: url, header: header);
      } else if (response.statusCode != 200) {
        return Constants.responseCallBack(
            isError: true, response: "Something when wrong.");
      } else {
        if (response.body == null || response.body.isEmpty) {
          return Constants.responseCallBack(
              isError: true, response: "Something when wrong.");
        } else {
          // var jsonResponse = convert.jsonDecode(response.body);
          return Constants.responseCallBack(
              isError: false, response: response.body);
        }
      }
    } on TimeoutException {
      // A timeout occurred.
      return Constants.responseCallBack(
          isError: true,
          response: "The connection has timed out, Please try again!");
    } on SocketException {
      return Constants.responseCallBack(
          isError: true,
          response:
              "No Internet Connection.Please Check your internet Connection.");
    } on Exception {
      return Constants.responseCallBack(
          isError: true, response: "Something when wrong.");
    }
  }

  static Future postApiCall(
      {required String? url,
      required String? header,
      required String? params}) async {
    try {
      Uri uri = Uri.parse(url ?? "");
      final bodyMap = convert.json.decode(params!);
        Map<String, String>? headerMap =
          Map<String, String>.from(convert.json.decode(header!));

      http.Response? response = await http
          .post(
            uri,
            body: bodyMap!,
            headers: headerMap,
          )
          .timeout(const Duration(seconds: 15),
              onTimeout: () => throw TimeoutException(
                  "The connection has timed out, Please try again!"));

      if (response.statusCode == 429) {
        //server is busy.
        await postApiCall(url: url, header: header, params: params);
      } else if (response.statusCode != 200) {
        return Constants.responseCallBack(
            isError: true, response: "Something when wrong.");
      } else {
        if (response.body == null || response.body.isEmpty) {
          return Constants.responseCallBack(
              isError: true, response: "Something when wrong.");
        } else {
          var jsonResponse = convert.jsonDecode(response.body);
          return Constants.responseCallBack(
              isError: false, response: jsonResponse);
        }
      }
    } on TimeoutException {
      // A timeout occurred.
      return Constants.responseCallBack(
          isError: true,
          response: "The connection has timed out, Please try again!");
    } on SocketException {
      return Constants.responseCallBack(
          isError: true,
          response:
              "No Internet Connection.Please Check your internet Connection.");
    } on Exception {
      return Constants.responseCallBack(
          isError: true, response: "Something when wrong.");
    }
  }

  static Future callPostEncodeApi(
      {required String? url,
      required String? header,
      required String? params}) async {
    try {
      Uri uri = Uri.parse(url ?? "");
      final bodyMap = convert.json.decode(params!);
        Map<String, String>? headerMap =
          Map<String, String>.from(convert.json.decode(header!));

      http.Response? response = await http
          .post(
            uri,
            body: bodyMap!,
            headers: headerMap,
            encoding: convert.Encoding.getByName("utf-8"),
          )
          .timeout(const Duration(seconds: 15),
              onTimeout: () => throw TimeoutException(
                  "The connection has timed out, Please try again!"));

      if (response.statusCode == 429) {
        //server is busy.
        await callPostEncodeApi(url: url, header: header, params: params);
      } else if (response.statusCode != 200) {
        return Constants.responseCallBack(
            isError: true, response: "Something when wrong.");
      } else {
        if (response.body == null || response.body.isEmpty) {
          return Constants.responseCallBack(
              isError: true, response: "Something when wrong.");
        } else {
          var jsonResponse = convert.jsonDecode(response.body);
          return Constants.responseCallBack(
              isError: false, response: jsonResponse);
        }
      }
    } on TimeoutException {
      // A timeout occurred.
      return Constants.responseCallBack(
          isError: true,
          response: "The connection has timed out, Please try again!");
    } on SocketException {
      return Constants.responseCallBack(
          isError: true,
          response:
              "No Internet Connection.Please Check your internet Connection.");
    } on Exception {
      return Constants.responseCallBack(
          isError: true, response: "Something when wrong.");
    }
  }

  static Future<dynamic> callPostFileUploadApi({
    required String? url,
    required String? header,
    required String? params,
    required String? filepath,
    required String? fileParmenter,
  }) async {
    Constants.debugLog(HttpCallGenerator, "callPostFileUploadApi:url:$url");
    Constants.debugLog(
        HttpCallGenerator, "callPostFileUploadApi:params:$params");
    Constants.debugLog(
        HttpCallGenerator, "callPostFileUploadApi:filename:$filepath");

    final bodyMap = convert.json.decode(params!);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url!));
      request.files.add(http.MultipartFile(fileParmenter!,
          File(filepath!).readAsBytes().asStream(), File(filepath).lengthSync(),
          filename: filepath.split("/").last));
      http.Response response =
          await http.Response.fromStream(await request.send()).timeout(
        const Duration(seconds: 60),
        onTimeout: () => throw TimeoutException(
            'The connection has timed out, Please try again!'),
      );

      if (response.statusCode == 429) {
        //server is busy.
        await callPostFileUploadApi(
            url: url,
            header: header,
            params: params,
            filepath: filepath,
            fileParmenter: fileParmenter);
      } else if (response.statusCode != 200) {
        return Constants.responseCallBack(
            isError: true, response: "Something when wrong.");
      } else {
        if (response.body == null || response.body.isEmpty) {
          return Constants.responseCallBack(
              isError: true, response: "Something when wrong.");
        } else {
          var jsonResponse = convert.jsonDecode(response.body);
          return Constants.responseCallBack(
              isError: false, response: jsonResponse);
        }
      }
    } on TimeoutException {
      // A timeout occurred.
      return Constants.responseCallBack(
          isError: true,
          response: "The connection has timed out, Please try again!");
    } on SocketException {
      return Constants.responseCallBack(
          isError: true,
          response:
              "No Internet Connection.Please Check your internet Connection.");
    } on Exception {
      return Constants.responseCallBack(
          isError: true, response: "Something when wrong.");
    }
  }
}
