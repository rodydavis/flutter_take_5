import 'package:flutter/material.dart';
import 'package:my_project/generated/i18n.dart';

import '../common/index.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _contacts = _dummyData();
  final _selection = ValueNotifier<Contact>(null);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimens) {
      if (dimens.maxWidth >= kTabletBreakpoint) {
        const kListViewWidth = 300.0;
        return Row(
          children: <Widget>[
            Container(
              width: kListViewWidth,
              child: buildListView(dimens, (val) {
                _selection.value = val;
              }),
            ),
            VerticalDivider(width: 0),
            Expanded(
                child: ValueListenableBuilder<Contact>(
              valueListenable: _selection,
              builder: (context, contact, child) {
                if (contact == null) {
                  return Scaffold(
                    appBar: AppBar(),
                    body: Center(child: Text(I18n.of(context).contactsEmpty)),
                  );
                }
                return ContactDetails(contact: contact);
              },
            ))
          ],
        );
      }
      return buildListView(dimens, (val) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ContactDetails(contact: val),
          ),
        );
      });
    });
  }

  Widget buildListView(BoxConstraints dimens, ValueChanged<Contact> onSelect) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(I18n.of(context).contactsTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              if (dimens.maxWidth >= kTabletBreakpoint) {
                showDialog(
                  context: context,
                  builder: (context) => Material(
                    color: Colors.transparent,
                    child: AdaptiveDialog(
                      child: ContactListFilterOptions(),
                    ),
                  ),
                );
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => ContactListFilterOptions(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(height: 0),
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final _contact = _contacts[index];
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(_contact.name),
            subtitle: Text(_contact.email),
            onTap: () => onSelect(_contact),
          );
        },
      ),
    );
  }
}

class ContactDetails extends StatelessWidget {
  final Contact contact;

  const ContactDetails({
    Key key,
    @required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).contactsDetails),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text(I18n.of(context).contactsName),
            subtitle: Text(contact.name),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(I18n.of(context).contactsEmail),
            subtitle: Text(contact.email),
          ),
        ],
      ),
    );
  }
}

List<Contact> _dummyData() {
  return [
    Contact('John Doe', 'john@app.com'),
    Contact('Susan Smith', 'susan@gmail.com'),
    Contact('James Hatfield', 'james.hatfield@yahoo.com'),
    Contact('Steve Jobs', 'steve@apple.com'),
    Contact('Bill Gates', 'gates@microsoft.com'),
    Contact('Elon Musk', 'elon@tesla.com'),
    Contact('John Smith', 'smith77@me.com'),
  ];
}

class Contact {
  final String name;
  final String email;

  Contact(this.name, this.email);
}

class ContactListFilterOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
