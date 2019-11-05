import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hunger_preventer/data/database/database_provider.dart';
import 'package:hunger_preventer/data/repositories/transaction_repository.dart';
import 'package:hunger_preventer/domain/bloc/transaction_list/transaction_list_bloc.dart';
import 'package:hunger_preventer/domain/bloc/transaction_list/transaction_list_event.dart';
import 'package:hunger_preventer/presentation/screens/transaction_list/transaction_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.folder),
            title: Text('transaction list'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.folder),
            title: Text('test'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                  child: BlocProvider(
                builder: (context) => TransactionListBloc(
                  TransactionRepository(
                    DatabaseProvider.database,
                  ),
                )..add(FetchTransactions()),
                child: TransactionList(),
              ));
            });
            break;
        }
        return Container();
      },
    );
  }
}
