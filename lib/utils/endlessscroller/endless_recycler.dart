import 'package:flutter/material.dart';

abstract class EndlessScrollListener {
  int visibleThreshold = 5;
  int currentPage = 0;
  int previousTotalItemCount = 0;
  bool loading = true;
  final int startingPageIndex = 0;
  final ScrollController scrollController;

  EndlessScrollListener(this.scrollController);

  void onScrolled() {
    final totalItemCount = scrollController.position.maxScrollExtent.toInt();
    final lastVisibleItemPosition = (scrollController.position.pixels /
            scrollController.position.viewportDimension *
            totalItemCount)
        .toInt();

    if (totalItemCount < previousTotalItemCount) {
      currentPage = startingPageIndex;
      previousTotalItemCount = totalItemCount;
      if (totalItemCount == 0) {
        loading = true;
      }
    }

    if (loading && totalItemCount > previousTotalItemCount) {
      loading = false;
      previousTotalItemCount = totalItemCount;
    }

    if (!loading &&
        lastVisibleItemPosition + visibleThreshold >= totalItemCount) {
      currentPage++;
      onLoadMore(currentPage, totalItemCount);
      loading = true;
    }
  }

  void resetState() {
    currentPage = startingPageIndex;
    previousTotalItemCount = 0;
    loading = true;
  }

  void onLoadMore(int page, int totalItemsCount);
}
