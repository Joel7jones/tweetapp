import 'package:flutter/material.dart';

class CommonWidgets {
  Widget get loadingWidget {
    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
  }

  Widget get errorWidget {
    return const Center(child: Text('Something went wrong!'));
  }

  Widget get noDataWidget {
    return const Center(child: Text('No Tweets Found!'));
  }

  Widget tweetText(String? tweet) {
    return Text('$tweet');
  }
}
