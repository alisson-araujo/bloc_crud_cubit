import 'package:crud_bloc_vls/app/models/contact_model.dart';
import 'package:crud_bloc_vls/app/modules/list/cubit/contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contatos')),
      body: Column(
        children: [
          BlocSelector<ContactsCubit, ContactsCubitState, List<ContactModel>>(
            selector: (state) {
              return state.maybeWhen(
                data: (contacts) => contacts,
                orElse: () => <ContactModel>[],
              );
            },
            builder: (_, contacts) {
              return Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (_, index) {
                    final contact = contacts[index];
                    return ListTile(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/contacts/update',
                        arguments: contact,
                      ),
                      trailing: IconButton(
                        onPressed: () =>
                            context.read<ContactsCubit>().delete(contact),
                        icon: Icon(Icons.delete, color: Colors.red[400]),
                      ),
                      title: Text(contact.name!),
                      subtitle: Text(contact.email!),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/contacts/register'),
      ),
    );
  }
}
