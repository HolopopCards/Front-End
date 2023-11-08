import 'package:flutter/material.dart';
import 'package:holopop/assets/holopop_colors.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TitleAndSettings(),
            Search(),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No cards found"),
                TextButton(
                  onPressed: () { },
                  child: Text("Add a card"),
                ),
              ]
            )),
          ]
        )
      )
    );
  }
}

class TitleAndSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("holopop"),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () { },
            ),
            IconButton(
              icon: Icon(Icons.settings_outlined),
              onPressed: () { },
            )
          ]
        )
      ]
    );
  }
}


class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
      onTap: () { },
      onChanged: (_) { },
      leading: Icon(Icons.search),
      hintText: 'Search cards',
    );
  }
}