import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_connection_practice2/repository/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(InitProductState()) {
    on<ProductEvent>(
      (event, emit) async {
        if (event is DefaultProductEvent) {
          await runDefaultEvent(event, emit);
        }
        if (event is PayProductEvent) {
          await runPayEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
    add(DefaultProductEvent());
    add(PayProductEvent(false));
  }

  runDefaultEvent(DefaultProductEvent event, emit) async {
    try {
      emit(LoadingProductState(
          defaultItems: state.defaultItems, payItems: state.payItems));
      var result = await productRepository.getDefaultProduct();
      emit(LoadedProductState(defaultItems: result, payItems: state.payItems));
    } catch (e) {
      emit(ErrorProductState(
        defaultItems: state.defaultItems,
        payItems: state.payItems,
        errorMessage: e.toString(),
      ));
    }
  }

  runPayEvent(PayProductEvent event, emit) async {
    try {
      emit(LoadingProductState(
          defaultItems: state.defaultItems, payItems: state.payItems));
      var result = await productRepository.getPayProduct(event.haslicense);
      emit(LoadedProductState(
          defaultItems: state.defaultItems, payItems: result));
    } catch (e) {
      emit(ErrorProductState(
        defaultItems: state.defaultItems,
        payItems: state.payItems,
        errorMessage: e.toString(),
      ));
    }
  }
}

abstract class ProductEvent extends Equatable {}

class DefaultProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class PayProductEvent extends ProductEvent {
  final bool haslicense;
  PayProductEvent(this.haslicense);
  @override
  List<Object?> get props => [];
}

abstract class ProductState extends Equatable {
  final List<String>? defaultItems;
  final List<String>? payItems;
  const ProductState({this.defaultItems, this.payItems});
}

class InitProductState extends ProductState {
  InitProductState() : super(defaultItems: [], payItems: []);

  @override
  List<Object?> get props => [defaultItems, payItems];
}

class LoadingProductState extends ProductState {
  const LoadingProductState({super.defaultItems, super.payItems});

  @override
  List<Object?> get props => [defaultItems, payItems];
}

class LoadedProductState extends ProductState {
  const LoadedProductState({super.defaultItems, super.payItems});

  @override
  List<Object?> get props => [defaultItems, payItems];
}

class ErrorProductState extends ProductState {
  const ErrorProductState({
    super.defaultItems,
    super.payItems,
    this.errorMessage,
  });
  final String? errorMessage;

  @override
  List<Object?> get props => [defaultItems, payItems, errorMessage];
}
