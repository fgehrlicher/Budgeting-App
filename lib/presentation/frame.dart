import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/data/database/database_provider.dart';
import 'package:unnamed_budgeting_app/data/repository/transaction_category_repository.dart';
import 'package:unnamed_budgeting_app/data/repository/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/presentation/screen.dart';
import 'package:unnamed_budgeting_app/presentation/screens/home/home.dart';
import 'package:unnamed_budgeting_app/presentation/screens/settings/settings.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/transactions_frame.dart';

class Frame extends StatefulWidget {
  @override
  _FrameState createState() => _FrameState();
}

List<Screen> _screens = <Screen>[
  Screen(
    icon: Icons.home,
    text: 'Home',
    widget: MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<HomeBloc>(
          builder: (BuildContext context) => HomeBloc()..add(FetchBalance()),
        ),
      ],
      child: Home(),
    ),
  ),
  Screen(
    icon: Icons.attach_money,
    text: 'Transactions',
    widget: MultiBlocProvider(
      providers: [
        BlocProvider<TransactionsBloc>(
          builder: (BuildContext context) => TransactionsBloc(
              TransactionRepository(
                database: DatabaseProvider.database,
              ),
              TransactionCategoryRepository(
                database: DatabaseProvider.database,
              ))
            ..add(LoadTransactions()),
        ),
      ],
      child: TransactionsFrame(),
    ),
  ),
  Screen(
    icon: Icons.settings,
    text: 'Settings',
    widget: Settings(),
  ),
];

class _FrameState extends State<Frame> {
  int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => NavigationBloc(),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
            body: _screens.elementAt(_currentPage).widget,
            bottomNavigationBar: BottomNavigationBar(
              items: _screens.map<BottomNavigationBarItem>((Screen screen) {
                return BottomNavigationBarItem(
                  icon: Icon(screen.icon),
                  title: Text(screen.text),
                );
              }).toList(),
              currentIndex: _currentPage,
              onTap: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
