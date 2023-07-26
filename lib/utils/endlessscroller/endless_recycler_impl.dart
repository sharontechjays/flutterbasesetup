import 'package:flutter/material.dart';

import 'endless_recycler.dart';


class EndlessScrollListenerImpl extends EndlessScrollListener {
  EndlessScrollListenerImpl(ScrollController scrollController)
      : super(scrollController);

  @override
  void onLoadMore(int page, int totalItemsCount) {

  }
}
