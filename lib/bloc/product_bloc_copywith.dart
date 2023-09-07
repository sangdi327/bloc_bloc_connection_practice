import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_connection_practice2/repository/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBlocCopyWith
    extends Bloc<ProductCopyWithEvent, ProductCopyWithState> {
  ProductRepository productRepository;
  ProductBlocCopyWith(this.productRepository)
      : super(ProductCopyWithState.init()) {
    on<ProductCopyWithEvent>(
      (event, emit) async {
        if (event is DefaultCopyWithEvent) {
          await runDefaultCopyWith(event, emit);
        }
        if (event is PayCopyWithEvent) {
          await runPayCopyWith(event, emit);
        }
      },
      transformer: sequential(),
    );

    add(DefaultCopyWithEvent());
    add(PayCopyWithEvent(false));
  }

  runDefaultCopyWith(DefaultCopyWithEvent event, emit) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
        defaultCopyWithItems: state.defaultCopyWithItems,
        payCopyWithItems: state.payCopyWithItems,
      ));
      var result = await productRepository.getDefaultProduct();
      emit(state.copyWith(
        status: Status.loaded,
        defaultCopyWithItems: result,
        payCopyWithItems: state.payCopyWithItems,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        defaultCopyWithItems: state.defaultCopyWithItems,
        payCopyWithItems: state.payCopyWithItems,
        errorMessage: e.toString(),
      ));
    }
  }

  runPayCopyWith(PayCopyWithEvent event, emit) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
        defaultCopyWithItems: state.defaultCopyWithItems,
        payCopyWithItems: state.payCopyWithItems,
      ));
      var result = await productRepository.getPayProduct(event.haslicense);
      emit(state.copyWith(
        status: Status.loaded,
        defaultCopyWithItems: state.defaultCopyWithItems,
        payCopyWithItems: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        defaultCopyWithItems: state.defaultCopyWithItems,
        payCopyWithItems: state.payCopyWithItems,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  void onTransition(
      Transition<ProductCopyWithEvent, ProductCopyWithState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }
}

enum Status {
  init,
  loading,
  loaded,
  error,
}

abstract class ProductCopyWithEvent extends Equatable {}

class DefaultCopyWithEvent extends ProductCopyWithEvent {
  @override
  List<Object?> get props => [];
}

class PayCopyWithEvent extends ProductCopyWithEvent {
  final bool haslicense;
  PayCopyWithEvent(this.haslicense);
  @override
  List<Object?> get props => [haslicense];
}

class ProductCopyWithState extends Equatable {
  final Status status;
  final String? errorMessage;
  final List<String>? defaultCopyWithItems;
  final List<String>? payCopyWithItems;
  const ProductCopyWithState({
    required this.status,
    this.errorMessage,
    this.defaultCopyWithItems,
    this.payCopyWithItems,
  });

  ProductCopyWithState.init()
      : this(
          status: Status.init,
          defaultCopyWithItems: [],
          payCopyWithItems: [],
        );

  ProductCopyWithState copyWith({
    Status? status,
    String? errorMessage,
    List<String>? defaultCopyWithItems,
    List<String>? payCopyWithItems,
  }) {
    return ProductCopyWithState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      defaultCopyWithItems: defaultCopyWithItems ?? this.defaultCopyWithItems,
      payCopyWithItems: payCopyWithItems ?? this.payCopyWithItems,
    );
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, defaultCopyWithItems, payCopyWithItems];
}
