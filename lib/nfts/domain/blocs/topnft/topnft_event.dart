// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'topnft_bloc.dart';

abstract class TopNftEvent extends Equatable {
  const TopNftEvent();

  @override
  List<Object> get props => [];
}

class GetTopNFTEvent extends TopNftEvent {}

class UpdateTopNFTEvent extends TopNftEvent {}

class GetSaveTopNFTEvent extends TopNftEvent {}

class ReseteSaveTopNFTEvent extends TopNftEvent {}

class ChooseTopNFTEvent extends TopNftEvent {}

class ChooseAditionalTopNFTEvent extends TopNftEvent {}

class SaveTopNFTEvent extends TopNftEvent {
  final bool? update;
  final TopNFTModel model;
  const SaveTopNFTEvent({
    required this.model,
    this.update,
  });
}

class RemoveTopNFTEvent extends TopNftEvent {
  final TopNFTModel model;
  const RemoveTopNFTEvent({
    required this.model,
  });
}

class ChangeTopIndexEvent extends TopNftEvent {
  final TopNFTModel index;
  const ChangeTopIndexEvent({
    required this.index,
  });
}

class ChangeTopStateImageEvent extends TopNftEvent {
  final Future<FileImage?> file;
  const ChangeTopStateImageEvent({
    required this.file,
  });
}

class ChangeTopStateAditionalImageEvent extends TopNftEvent {
  final Future<List<FileImage>?> file;
  const ChangeTopStateAditionalImageEvent({
    required this.file,
  });
}
