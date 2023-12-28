// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'nft_bloc.dart';

abstract class NftEvent extends Equatable {
  const NftEvent();

  @override
  List<Object> get props => [];
}

class GetNFTEvent extends NftEvent {}

class UpdateNFTEvent extends NftEvent {}

class GetSaveNFTEvent extends NftEvent {}

class ReseteSaveNFTEvent extends NftEvent {}

class ChooseNFTEvent extends NftEvent {}

class SaveNFTEvent extends NftEvent {
  final NFTModel model;
  const SaveNFTEvent({
    required this.model,
  });
}

class RemoveNFTEvent extends NftEvent {
  final NFTModel model;
  const RemoveNFTEvent({
    required this.model,
  });
}

class ChangeIndexEvent extends NftEvent {
  final NFTModel index;
  const ChangeIndexEvent({
    required this.index,
  });
}

class ChangeStateImageEvent extends NftEvent {
  final Future<FileImage?> file;
  const ChangeStateImageEvent({
    required this.file,
  });
}
