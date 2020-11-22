import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formusers/cubit/UserAdmin_cubit.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String str = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User"),
      ),
      body: BlocConsumer<AdminUserCubit, AdminUserState>(
        listener: (context, state) {
          if (state is AdminUserError) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return _buildbody();
        },
      ),
    );
  }

  Widget _buildbody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                ),
                validator: (value) {
                  if (value.length > 0) {
                    return null;
                  } else {
                    return "Debe introducir un username";
                  }
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value.length > 0) {
                    if (value.length < 6) return "Debe ser mayor a 6 digitos";

                    return null;
                  } else {
                    return "Debe introducir un password";
                  }
                },
              ),
              SizedBox(height: 20.0),
              Container(
                width: 200.0,
                child: RaisedButton(
                  child: Text("Agregar"),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      final username = _usernameController.text;
                      final passsword = _passwordController.text;

                      context
                          .bloc<AdminUserCubit>()
                          .create(username, passsword);

                      _usernameController.clear();
                      _passwordController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
