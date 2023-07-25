import 'package:flutter/material.dart';

import 'endless_recycler.dart';

class EndlessScrollListenerImpl extends EndlessScrollListener {
  EndlessScrollListenerImpl(ScrollController scrollController)
      : super(scrollController);

  @override
  void onLoadMore(int page, int totalItemsCount) {
    // Implement the logic to load more items here.
    // This method will be called when the user reaches the end of the list.
    // You can add your own logic to fetch more items based on the current page and total items count.
    // For now, let's leave it empty.
  }
}
