import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/widgets/app_progress_indicator.dart';

class AppPaginatedPage<T> {
  const AppPaginatedPage({
    required this.items,
    required this.totalCount,
    required this.pageSize,
    required this.pageNumber,
  });

  final List<T> items;
  final int totalCount;
  final int pageSize;
  final int pageNumber;

  int get totalPages =>
      pageSize <= 0 ? 1 : math.max(1, (totalCount / pageSize).ceil());
}

class AppPaginatedScroll<T> extends StatefulWidget {
  const AppPaginatedScroll({
    required this.items,
    required this.initialPage,
    required this.getPaginatedItems,
    required this.builder,
    super.key,
    this.enabled = true,
    this.reverse = false,
    this.onRefresh,
    this.onPageChanged,
    this.onError,
    this.onPagesFinished,
    this.loadingPadding = const EdgeInsets.only(bottom: 8),
    this.unconstrained = true,
    this.loadThreshold = 80,
  });

  final bool enabled;
  final bool unconstrained;
  final bool reverse;
  final List<T> items;
  final AppPaginatedPage<T> initialPage;
  final Widget Function(BuildContext context, List<T> items) builder;
  final Future<AppPaginatedPage<T>> Function(int page) getPaginatedItems;
  final Future<AppPaginatedPage<T>> Function()? onRefresh;
  final void Function(AppPaginatedPage<T> page, List<T> items)? onPageChanged;
  final void Function(
    BuildContext context,
    Object error,
    StackTrace stackTrace,
  )?
  onError;
  final void Function(int maxPage)? onPagesFinished;
  final EdgeInsetsGeometry loadingPadding;
  final double loadThreshold;

  @override
  State<AppPaginatedScroll<T>> createState() => _AppPaginatedScrollState<T>();
}

class _AppPaginatedScrollState<T> extends State<AppPaginatedScroll<T>> {
  late List<T> _items;
  late int _currentPage;
  late int _totalCount;
  late int _pageSize;
  bool _isLoading = false;
  bool _pagesFinishedNotified = false;
  bool _hasReachedEnd = false;

  int get _maxPage =>
      _pageSize <= 0 ? 1 : math.max(1, (_totalCount / _pageSize).ceil());

  @override
  void initState() {
    super.initState();
    _resetFromWidget();
  }

  @override
  void didUpdateWidget(covariant AppPaginatedScroll<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.items, widget.items)) {
      _resetFromWidget();
    }
  }

  void _resetFromWidget() {
    _items = List<T>.of(widget.items);
    _currentPage = widget.initialPage.pageNumber;
    _totalCount = widget.initialPage.totalCount;
    _pageSize = widget.initialPage.pageSize;
    _hasReachedEnd = _items.length >= _totalCount || _currentPage >= _maxPage;
    _pagesFinishedNotified = _hasReachedEnd;
  }

  bool get _hasMore =>
      widget.enabled &&
      !_hasReachedEnd &&
      _items.length < _totalCount &&
      _currentPage < _maxPage;

  bool _shouldLoad(ScrollNotification notification) {
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) {
      return false;
    }

    return widget.reverse
        ? notification.metrics.pixels <= widget.loadThreshold
        : notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - widget.loadThreshold;
  }

  bool _onScroll(ScrollNotification notification) {
    if (_shouldLoad(notification) && _hasMore) {
      unawaited(_loadNextPage());
    }
    return false;
  }

  Future<void> _loadNextPage() async {
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);

    try {
      final page = await widget.getPaginatedItems(_currentPage + 1);
      if (!mounted) return;

      _appendPage(page);
      widget.onPageChanged?.call(page, List<T>.unmodifiable(_items));
    } on Object catch (error, stackTrace) {
      if (!mounted) return;
      _reportError(error, stackTrace);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _appendPage(AppPaginatedPage<T> page) {
    _items.addAll(page.items);
    _updatePageMetadata(page);
    _hasReachedEnd = page.items.isEmpty;
    _notifyIfFinished();
  }

  void _updatePageMetadata(AppPaginatedPage<T> page) {
    _currentPage = page.pageNumber;
    _totalCount = page.totalCount;
    _pageSize = page.pageSize;
  }

  void _notifyIfFinished() {
    if ((_hasReachedEnd || !_hasMore) && !_pagesFinishedNotified) {
      _pagesFinishedNotified = true;
      widget.onPagesFinished?.call(_maxPage);
    }
  }

  Future<void> _refresh() async {
    final refresh = widget.onRefresh;
    if (refresh == null || _isLoading) return;

    setState(() => _isLoading = true);
    try {
      final page = await refresh();
      if (!mounted) return;

      _items = List<T>.of(page.items);
      _updatePageMetadata(page);
      _hasReachedEnd =
          page.items.isEmpty ||
          _items.length >= _totalCount ||
          _currentPage >= _maxPage;
      _pagesFinishedNotified = false;
      _notifyIfFinished();
      widget.onPageChanged?.call(page, List<T>.unmodifiable(_items));
    } on Object catch (error, stackTrace) {
      if (!mounted) return;
      _reportError(error, stackTrace);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _reportError(Object error, StackTrace stackTrace) {
    final onError = widget.onError;
    if (onError != null) {
      onError(context, error, stackTrace);
      return;
    }

    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'AppPaginatedScroll',
        context: ErrorDescription('while loading a paginated list'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.builder(context, List<T>.unmodifiable(_items));
    final scrollable = NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: widget.unconstrained ? content : SizedBox.expand(child: content),
    );
    final refresh = widget.onRefresh;
    final body = refresh == null
        ? scrollable
        : RefreshIndicator(onRefresh: _refresh, child: scrollable);

    return Stack(
      children: [
        body,
        if (_isLoading)
          Positioned(
            bottom: context.h(16),
            left: 0,
            right: 0,
            child: Padding(
              padding: widget.loadingPadding,
              child: const Center(child: AppProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
