import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tweetapp/common/common_widgets.dart';
import 'package:tweetapp/constants/collections_names.dart';
import 'package:tweetapp/controller/auth_controller.dart';
import 'package:tweetapp/model/tweet_model.dart';
import 'package:tweetapp/router/app_routes.dart';
import 'package:tweetapp/view/shared/tweets_card.dart';

import '../controller/tweet_controller.dart';

class HomeScreen extends StatefulWidget {
  final GoogleSignInAccount googleAccount;
  const HomeScreen({super.key, required this.googleAccount});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _widgets = CommonWidgets();
  final authCtrlr = Get.put(AuthController());
  final Stream<TweetsModel> _tweetsStream = FirebaseFirestore.instance
      .collection(tweetsCollect)
      .doc(tweetsDoc)
      .snapshots()
      .map((event) {
    return tweetsModelFromJson(jsonEncode(event.data()));
  });

  @override
  Widget build(BuildContext context) {
    final tweetCtrlr = Get.put(TweetController());
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.hardEdge,
          child: Image.network(widget.googleAccount.photoUrl ?? ''),
        ),
        title: Text(
          widget.googleAccount.displayName ?? '',
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await authCtrlr.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<TweetsModel>(
        stream: _tweetsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _widgets.errorWidget;
          } else if (snapshot.hasData) {
            var tweets = snapshot.data?.tweetItems ?? [];
            tweets.sort(
              (a, b) =>
                  DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)),
            );
            tweetCtrlr.allTweets.value = snapshot.data!;
            if (tweets.isEmpty) {
              return _widgets.noDataWidget;
            }

            return ListView.builder(
              itemCount: tweets.length,
              itemBuilder: (context, index) {
                var data = tweets[index];
                return TweetCard(
                  tweetData: data,
                  editAction: () async {
                    tweetCtrlr.currentTweet.value = data;
                    Get.toNamed(Routes.tweetScreen, arguments: [data]);
                  },
                  deleteAction: () async {
                    tweetCtrlr.deleteTweet(data.id!);
                  },
                );
              },
            );
          }

          return _widgets.loadingWidget;
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.add_circled),
        onPressed: () {
          Get.toNamed(Routes.tweetScreen, arguments: [null]);
        },
      ),
    );
  }
}
