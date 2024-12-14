import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final void Function(String query) onSearch;

  const SearchWidget({required this.onSearch, super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: _isExpanded ? MediaQuery.of(context).size.width * 0.6 : 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          if (_isExpanded)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search movies...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (query) {
                    widget.onSearch(query);
                    setState(() {
                      _isExpanded = false;
                    });
                  },
                ),
              ),
            ),
          IconButton(
            icon: Icon(
              _isExpanded ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (_isExpanded) {
                  _controller.clear();
                }
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ],
      ),
    );
  }
}


