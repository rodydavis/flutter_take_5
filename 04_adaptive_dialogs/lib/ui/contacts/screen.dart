import 'package:flutter/material.dart';
import 'package:my_project/ui/common/index.dart';

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
              child: buildListView((val) {
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
                    body: Center(child: Text('No Contact Selected')),
                  );
                }
                return ContactDetails(contact: contact);
              },
            ))
          ],
        );
      }
      return buildListView((val) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ContactDetails(contact: val),
          ),
        );
      });
    });
  }

  Widget buildListView(ValueChanged<Contact> onSelect) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Contacts'),
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
        title: Text('Details'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Name'),
            subtitle: Text(contact.name),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
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
