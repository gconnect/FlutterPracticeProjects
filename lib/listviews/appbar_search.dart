import 'package:flutter/material.dart';

class SearchAppBarDelegate extends SearchDelegate<String> {
  final List<String> _data;
  final List<String> _history;

  SearchAppBarDelegate(List<String> data)
      : _data = data,
        //Prepulated history of words
        _history = <String>["bible", "devotional", "study guide"],
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
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _data.where((dataList) => dataList.startsWith(query));
    return _ChoiceSuggestionList(
        query: this.query,
        suggestions: suggestions.toList(),
        onSelected: (String suggestion) {
          this.query = suggestion;
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
  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      final String suggestion = suggestions[index];
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
          onSelected(suggestion);
        },
      );
    });
  }
}

showSearchPage(
    BuildContext context, SearchAppBarDelegate searchDelegate) async {
  final String selected =
      await showSearch<String>(context: context, delegate: searchDelegate);
//  if (selected != null) {
//    Scaffold.of(context).showSnackBar(SnackBar(
//      content: Text("Your word choice $selected"),
//    ));
//  }
  print(selected);
}
