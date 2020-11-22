import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formusers/cubit/UserAdmin_cubit.dart';

import 'package:formusers/pages/create_user_page.dart';
import 'package:formusers/pages/update_user_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.bloc<AdminUserCubit>().getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Users"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateUserPage(),
                ),
              );
            },
          )
        ],
      ),
      body: BlocConsumer<AdminUserCubit, AdminUserState>(
        listener: (context, state) {
          if (state is AdminUserError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminUserLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AdminUserLoaded) {
            final userentitieslist = state.userEntities;
            return ListView.builder(
              itemCount: userentitieslist.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.horizontal,
                  background: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.update,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      context
                          .bloc<AdminUserCubit>()
                          .delete(userentitieslist[index].id);
                      setState(() {
                        userentitieslist.removeAt(index);
                      });
                    } else if (direction == DismissDirection.startToEnd) {
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdateUserPage(
                              id: userentitieslist[index].id,
                            ),
                          ),
                        );
                      });
                    }
                  },
                  child: ListTile(
                      title: Text(userentitieslist[index].username),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(userentitieslist[index].id.toString()),
                          Text(userentitieslist[index].password),
                        ],
                      )),
                  key: UniqueKey(),
                );
              },
            );
          } else {
            return Center(
              child: Text("Cargando..."),
            );
          }
        },
      ),
    );
  }
}
