import 'package:bloc_connection_practice2/bloc/license_bloc.dart';
import 'package:bloc_connection_practice2/bloc/product_bloc_copywith.dart';
import 'package:bloc_connection_practice2/components/lock_widget.dart';
import 'package:bloc_connection_practice2/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The connection of blocs'),
        centerTitle: true,
      ),
      body: BlocListener<LicenseBloc, LicenseState>(
        listener: (context, state) {
          if (state.haslicense) {
            context
                .read<ProductBlocCopyWith>()
                .add(PayCopyWithEvent(state.haslicense));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                DefaultItemsList(),
                SizedBox(
                  height: 10,
                ),
                PayItemsList()
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LicenseBloc>().add(LicenseEvent());
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
              child: const Text('Get the license!'),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class DefaultItemsList extends StatelessWidget {
  const DefaultItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBlocCopyWith>().state;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Default items',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          if (state.status == Status.loading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (state.status == Status.loaded)
            ProductWidget(
                items: List.generate(
              state.defaultCopyWithItems?.length ?? 0,
              (index) => index.toString(),
            ))
        ],
      ),
    );
  }
}

class PayItemsList extends StatelessWidget {
  const PayItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBlocCopyWith>().state;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Pay items',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          if (state.status == Status.loading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (state.status == Status.loaded && state.payCopyWithItems == null)
            const LockWidget(),
          if (state.status == Status.loaded && state.payCopyWithItems != null)
            ProductWidget(
                items: List.generate(
              state.payCopyWithItems?.length ?? 0,
              (index) => index.toString(),
            ))
        ],
      ),
    );
  }
}
