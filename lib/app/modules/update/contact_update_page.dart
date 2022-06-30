import 'package:crud_bloc_vls/app/modules/update/cubit/update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/contact_model.dart';

class ContactUpdatePage extends StatefulWidget {
  final ContactModel contact;

  const ContactUpdatePage({super.key, required this.contact});

  @override
  State<ContactUpdatePage> createState() => _ContactUpdatePageState();
}

class _ContactUpdatePageState extends State<ContactUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameEc;
  late final TextEditingController _emailEc;

  @override
  void initState() {
    super.initState();
    _nameEc = TextEditingController(text: widget.contact.name);
    _emailEc = TextEditingController(text: widget.contact.email);
  }

  @override
  void dispose() {
    _nameEc.dispose();
    _emailEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: BlocListener<ContactUpdateCubit, ContactUpdateState>(
        listener: (_, state) {
          state.whenOrNull(
              success: () =>
                  Navigator.popAndPushNamed(context, '/contacts/list'),
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              });
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEc,
                  decoration: const InputDecoration(label: Text('nome')),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailEc,
                  decoration: const InputDecoration(label: Text('email')),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Email é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final validate = _formKey.currentState?.validate() ?? false;
                    if (validate) {
                      final contact = ContactModel(
                        id: widget.contact.id,
                        name: _nameEc.text,
                        email: _emailEc.text,
                      );
                      context.read<ContactUpdateCubit>().update(contact);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
