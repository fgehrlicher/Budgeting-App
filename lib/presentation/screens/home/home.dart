import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hunger_preventer/domain/bloc/home/home_bloc.dart';
import 'package:hunger_preventer/domain/bloc/home/home_state.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    this._homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is EmptyBalance) {
          return Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Error",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[800]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        if (state is CalculatingBalance) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is BalanceCalculated) {
          return Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Available Amount:",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[800]),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    state.accountBalance.balance.toString() + " \$",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
