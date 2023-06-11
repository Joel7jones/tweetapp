import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweetapp/common/common_widgets.dart';
import 'package:tweetapp/helpers/extensions/date_time_extension.dart';
import 'package:tweetapp/model/tweet_model.dart';

class TweetCard extends StatelessWidget {
  final TweetItem tweetData;
  final void Function()? editAction;
  final void Function()? deleteAction;
  TweetCard(
      {super.key, required this.tweetData, this.editAction, this.deleteAction});

  final _widgets = CommonWidgets();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _widgets.tweetText(tweetData.tweet),
      subtitle: Row(
        children: [
          Text(
            DateTime.parse(tweetData.date!).toMMMDDYYYY,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const Spacer(),
          IconButton(
              onPressed: editAction,
              icon: const Icon(
                CupertinoIcons.pencil_ellipsis_rectangle,
                color: Colors.blue,
              )),
          IconButton(
              onPressed: deleteAction,
              icon: const Icon(CupertinoIcons.delete, color: Colors.red)),
        ],
      ),
    );
  }
}
