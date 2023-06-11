import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tweetapp/constants/collections_names.dart';
import 'package:tweetapp/constants/storage_key_names.dart';
import 'package:tweetapp/model/user_model.dart';
import 'package:tweetapp/router/app_routes.dart';

import '../helpers/storage/secure_storage.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  GoogleSignInAccount? _currentUser;
  final _secureStorageHelper = SecureStorageHelper();

  @override
  void onInit() {
    super.onInit();
    instantiateAuth();
  }

  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final _googleSignIn = GoogleSignIn(scopes: scopes);

  instantiateAuth() async {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      _currentUser = account;
    });
  }

  Future<void> signIn() async {
    isLoading.value = true;
    try {
      _currentUser = await _googleSignIn.signIn();
      if (_currentUser != null) {
        final docUser =
            FirebaseFirestore.instance.collection(usersCollect).doc();
        var user = UserModel(
            name: _currentUser?.displayName ?? '',
            id: _currentUser?.id ?? '',
            email: _currentUser?.email ?? '');
        await docUser.set(user.toJson());
        isLoading.value = false;
        await _secureStorageHelper.addNewData(
            userKey, jsonEncode(user.toJson()));
        Get.offAndToNamed(Routes.homeScreen, arguments: _currentUser);
      }
    } catch (error) {
      isLoading.value = false;
      debugPrint('$error');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _secureStorageHelper.deleteAll;
    Get.offAndToNamed(Routes.authScreen);
  }
}
