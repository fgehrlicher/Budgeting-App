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

class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  static const INITIAL_PAGE = 0;

  PageController _pageController;
  int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = INITIAL_PAGE;
    _pageController = PageController(initialPage: INITIAL_PAGE);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => NavigationBloc(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 4.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.home),
                      onPressed: () {
                        var newIndex = 0;
                        BlocProvider.of<NavigationBloc>(context).add(
                          NavigateToPage(
                            lastIndex: _currentPage,
                            targetIndex: newIndex,
                          ),
                        );

                        setState(() {
                          _pageController.jumpToPage(newIndex);
                          _currentPage = newIndex;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.attach_money),
                      onPressed: () {
                        var newIndex = 1;
                        BlocProvider.of<NavigationBloc>(context).add(
                          NavigateToPage(
                            lastIndex: _currentPage,
                            targetIndex: newIndex,
                          ),
                        );

                        setState(() {
                          _pageController.jumpToPage(newIndex);
                          _currentPage = newIndex;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: PageView(
              controller: _pageController,
              children: <Widget>[
                MultiBlocProvider(
                  providers: <BlocProvider>[
                    BlocProvider<HomeBloc>(
                      builder: (BuildContext context) =>
                          HomeBloc()..add(FetchBalance()),
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
