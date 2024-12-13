import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final void Function(String query) onSearch;

  const SearchWidget({required this.onSearch, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search movies...',
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white10,
        ),
        onSubmitted: onSearch,
      ),
    );
  }
}

