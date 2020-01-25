import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/data/database/database_provider.dart';
import 'package:unnamed_budgeting_app/data/repositories/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/presentation/screens/home/home.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/transactions.dart';

class Frame extends StatefulWidget {
  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int _currentPage;
  List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _screens = <Widget>[
      MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<HomeBloc>(
            builder: (BuildContext context) => HomeBloc()..add(FetchBalance()),
          ),
        ],
        child: Home(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider<TransactionsBloc>(
            builder: (BuildContext context) => TransactionsBloc(
              TransactionRepository(
                DatabaseProvider.database,
              ),
            )..add(LoadTransactions()),
          ),
        ],
        child: Transactions(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => NavigationBloc(),
      child: Scaffold(
        body: _screens.elementAt(_currentPage),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              title: Text('Transactions'),
            ),
          ],
          currentIndex: _currentPage,
          onTap: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }
}
