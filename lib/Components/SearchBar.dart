

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {

  final ValueChanged<List<dynamic>> searchResultChanged;
  List<dynamic> constData;
  List<dynamic> data;

  SearchBar({Key? key, required this.data, required this.constData, required this.searchResultChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  TextEditingController editingController = TextEditingController();

  void filterSearchResults(String query) {
    List<dynamic> searchList = [];
    searchList.addAll(widget.data);

    if(query.isNotEmpty) {
      List<dynamic> searchListResults = [];

      for (var element in searchList) {
        if(element.name.contains(query)) {
          searchListResults.add(element);
        }
      }
      print(searchListResults);
      widget.searchResultChanged(searchListResults);
      return;
    }
    print('empty query');
    widget.searchResultChanged(widget.constData);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => filterSearchResults(value),
      controller: editingController,
      decoration: const InputDecoration(
          labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }
}