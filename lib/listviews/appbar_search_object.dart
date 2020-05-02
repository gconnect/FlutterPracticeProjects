import 'package:flutter/material.dart';
import 'package:formvalidation/data/TabChoice.dart';

class SearchAppBarDelegate2 extends SearchDelegate<String> {
  final List<TabChoice> _data;
  final List<TabChoice> _history;

  SearchAppBarDelegate2(List<TabChoice> data)
      : _data = data,
        //Prepulated history of words
        _history = <TabChoice>[
          TabChoice("Devotional", Icons.directions),
          TabChoice("Bible", Icons.directions),
          TabChoice("Puzzle", Icons.directions),
        ],
        super();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: "Back",
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        this.close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Your Word Choice"),
            GestureDetector(
              onTap: () {
                //Define your action when clicking on result
                this.close(context, this.query);
              },
              child: Text(
                this.query,
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<TabChoice> suggestions =
        this.query.isEmpty ? _history : _data;
//        : _data.where((dataList) => dataList.startsWith(query));
    return _ChoiceSuggestionList(
        query: this.query,
        suggestions: suggestions.toList(),
        onSelected: (TabChoice suggestion) {
          this.query = suggestion.title;
          this._history.insert(0, suggestion);
          showResults(context);
        });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              tooltip: "clear",
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = "";
                showSuggestions(context);
              },
            )
          : IconButton(
              icon: const Icon(Icons.mic),
              tooltip: "Voice Input",
              onPressed: () {
                this.query = "Get input from voice";
              },
            )
    ];
  }
}

class _ChoiceSuggestionList extends StatelessWidget {
  const _ChoiceSuggestionList({this.suggestions, this.query, this.onSelected});
  final List<TabChoice> suggestions;
  final String query;
  final ValueChanged<TabChoice> onSelected;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      final String suggestion = suggestions[index].title;
      return ListTile(
        leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
        title: RichText(
          text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: suggestion.substring(query.length), style: textTheme)
              ]),
        ),
        onTap: () {
//          onSelected(suggestion);
        },
      );
    });
  }
}

showSearchPage2(
    BuildContext context, SearchAppBarDelegate2 searchDelegate) async {
  final String selected =
      await showSearch<String>(context: context, delegate: searchDelegate);
//  if (selected != null) {
//    Scaffold.of(context).showSnackBar(SnackBar(
//      content: Text("Your word choice $selected"),
//    ));
//  }
  print(selected);
}
