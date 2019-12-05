import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hunger_preventer/data/database/database_provider.dart';
import 'package:hunger_preventer/data/repositories/transaction_repository.dart';
import 'package:hunger_preventer/domain/bloc/home/home_bloc.dart';
import 'package:hunger_preventer/domain/bloc/home/home_event.dart';
import 'package:hunger_preventer/domain/bloc/transactions/transactions_bloc.dart';
import 'package:hunger_preventer/domain/bloc/transactions/transactions_event.dart';
import 'package:hunger_preventer/presentation/screens/home/home.dart';
import 'package:hunger_preventer/presentation/screens/transactions/transactions.dart';

class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      builder: (context) => HomeBloc()..add(FetchCurrentBalance()),
      child: Home(),
    ),
    BlocProvider(
      builder: (context) => TransactionsBloc(
        TransactionRepository(
          DatabaseProvider.database,
        ),
      )..add(FetchTransactions()),
      child: Transactions(),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Transactions'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
