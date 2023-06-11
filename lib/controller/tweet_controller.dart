import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tweetapp/model/tweet_model.dart';
import 'package:tweetapp/model/user_model.dart';

import '../common/firestore_crud_operations.dart';
import '../constants/storage_key_names.dart';
import '../helpers/storage/secure_storage.dart';

class TweetController extends GetxController {
  var isLoading = false.obs;
  var currentTweet = TweetItem().obs;
  final tweetOperations = TweetOperations();
  var allTweets = TweetsModel().obs;

  clearData() {
    currentTweet.value = TweetItem();
  }

  Future<void> updateTweet({bool isUpdated = false}) async {
    isLoading.value = true;
    try {
      if (isUpdated) {
        allTweets.value.tweetItems
            ?.firstWhere((element) => element.id == currentTweet.value.id)
            .tweet = currentTweet.value.tweet;
        allTweets.value.tweetItems
            ?.firstWhere((element) => element.id == currentTweet.value.id)
            .date = '${DateTime.now().toIso8601String()}Z';
      } else {
        SecureStorageHelper secureStorageHelper = SecureStorageHelper();
        String userData = await secureStorageHelper.read(userKey);
        UserModel user = userModelFromJson(userData);
        currentTweet.value.date = '${DateTime.now().toIso8601String()}Z';
        currentTweet.value.id = allTweets.value.tweetItems?.length;
        currentTweet.value.userId = user.id;
        allTweets.value.tweetItems?.add(currentTweet.value);
      }

      await tweetOperations
          .editTweet(jsonDecode(tweetsModelToJson(allTweets.value)));
      Get.back();
    } catch (e) {
      debugPrint('$e');
    }
    isLoading.value = false;
  }

  deleteTweet(num id) async {
    allTweets.value.tweetItems?.removeWhere((element) => element.id == id);
    await tweetOperations
        .editTweet(jsonDecode(tweetsModelToJson(allTweets.value)));
  }
}
