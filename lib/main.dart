import 'package:crud_bloc_vls/app/models/contact_model.dart';
import 'package:crud_bloc_vls/app/modules/home/home_page.dart';
import 'package:crud_bloc_vls/app/modules/list/contacts_list_page.dart';
import 'package:crud_bloc_vls/app/modules/list/cubit/contacts_cubit.dart';
import 'package:crud_bloc_vls/app/modules/register/contacts_register_page.dart';
import 'package:crud_bloc_vls/app/modules/register/cubit/register_cubit.dart';
import 'package:crud_bloc_vls/app/modules/update/contact_update_page.dart';
import 'package:crud_bloc_vls/app/modules/update/cubit/update_cubit.dart';
import 'package:crud_bloc_vls/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactsRepository(),
      child: MaterialApp(
        initialRoute: '/home',
        title: 'CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          '/home': (_) => const HomePage(),
          '/contacts/list': (context) {
            return BlocProvider(
              create: (context) => ContactsCubit(
                repository: context.read(),
              )..findAll(),
              child: const ContactsListPage(),
            );
          },
          '/contacts/register': (_) {
            return BlocProvider(
              create: (context) => ContactRegisterCubit(
                contactsRepository: context.read(),
              ),
              child: const ContactRegisterPage(),
            );
          },
          '/contacts/update': (context) {
            final contact =
                ModalRoute.of(context)!.settings.arguments as ContactModel;
            return BlocProvider(
              create: (context) => ContactUpdateCubit(
                contactsRepository: context.read(),
              ),
              child: ContactUpdatePage(contact: contact),
            );
          }
        },
      ),
    );
  }
}
