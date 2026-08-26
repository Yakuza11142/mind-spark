import 'package:flutter/material.dart';

class BookmarkButton extends StatefulWidget {
  final bool isBookmarked;
  final ValueChanged<bool> onBookmarkChanged;

  const BookmarkButton({
    Key? key,
    required this.isBookmarked,
    required this.onBookmarkChanged,
  }) : super(key: key);

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  late bool _bookmarked;

  @override
  void initState() {
    super.initState();
    _bookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _bookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
        color: _bookmarked ? Colors.amber : Colors.white70,
      ),
      onPressed: () {
        setState(() {
          _bookmarked = !_bookmarked;
        });
        widget.onBookmarkChanged(_bookmarked);
      },
    );
  }
}
