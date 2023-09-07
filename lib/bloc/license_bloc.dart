import 'package:bloc_connection_practice2/repository/license_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  LicenseRepository licenseRepository;

  LicenseBloc(this.licenseRepository) : super(const LicenseState(false)) {
    on<LicenseEvent>((event, emit) async {
      var result = await licenseRepository.getLicense();

      emit(LicenseState(result));
    });
  }
}

class LicenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LicenseState extends Equatable {
  final bool haslicense;
  const LicenseState(this.haslicense);
  @override
  List<Object?> get props => [haslicense];
}
