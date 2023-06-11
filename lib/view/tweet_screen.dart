import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tweetapp/common/common_widgets.dart';
import 'package:tweetapp/controller/tweet_controller.dart';
import 'package:tweetapp/model/tweet_model.dart';

class TweetScreen extends StatefulWidget {
  final TweetItem? tweetItem;
  const TweetScreen({super.key, required this.tweetItem});

  @override
  State<TweetScreen> createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen> {
  final tweetformkey = GlobalKey<FormState>();
  final _widgets = CommonWidgets();

  @override
  Widget build(BuildContext context) {
    final tweetCtrlr = Get.find<TweetController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            if (tweetCtrlr.isLoading.value) {
              return _widgets.loadingWidget;
            }
            return Form(
              key: tweetformkey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.tweetItem?.tweet,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Tweet'),
                    maxLength: 280,
                    maxLines: 8,
                    onChanged: (value) {
                      tweetCtrlr.currentTweet.value.tweet = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Type your tweet";
                      } else {
                        return null;
                      }
                    },
                  ),
                  FilledButton(
                      onPressed: () async {
                        if (tweetformkey.currentState!.validate()) {
                          await tweetCtrlr.updateTweet(
                              isUpdated: widget.tweetItem != null);
                        }
                      },
                      child: const Text('Tweet'))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
