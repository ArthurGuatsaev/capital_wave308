import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../../import.dart';
import 'package:equatable/equatable.dart';

part 'nft_event.dart';
part 'nft_state.dart';

class NftBloc extends Bloc<NftEvent, NftState> {
  final NFTRepository nftRepository;
  NftBloc({required this.nftRepository}) : super(const NftState()) {
    on<GetSaveNFTEvent>(getSaveNft);
    on<UpdateNFTEvent>(updateNFT);
    on<SaveNFTEvent>(saveNFT);
    on<RemoveNFTEvent>(removeNFT);
    on<ReseteSaveNFTEvent>(reseteNFT);
    on<ChooseNFTEvent>(chooseImage);
    on<ChangeIndexEvent>(changeIndex);
    on<ChangeStateImageEvent>(changeStateImage);
  }

  getSaveNft(GetSaveNFTEvent event, Emitter<NftState> emit) {
    final nft = nftRepository.nft;
    emit(state.copyWith(nft: nft));
  }

  updateNFT(UpdateNFTEvent event, Emitter<NftState> emit) async {
    final nft = await nftRepository.getSaveNFT();
    emit(state.copyWith(nft: nft, image: null));
  }

  saveNFT(SaveNFTEvent event, Emitter<NftState> emit) async {
    await nftRepository.saveImage(
        image: state.image, key: '${event.model.myId!}');
    await nftRepository.saveNFT(note: event.model);
    add(UpdateNFTEvent());
  }

  removeNFT(RemoveNFTEvent event, Emitter<NftState> emit) async {
    await nftRepository.deleteNFT(event.model);
    add(UpdateNFTEvent());
  }

  reseteNFT(ReseteSaveNFTEvent event, Emitter<NftState> emit) async {
    await nftRepository.reseteNFT();
    add(UpdateNFTEvent());
  }

  chooseImage(ChooseNFTEvent event, Emitter<NftState> emit) async {
    final image = await nftRepository.getNewImage();
    emit(state.copyWith(image: image));
  }

  changeIndex(ChangeIndexEvent event, Emitter<NftState> emit) async {
    final index = state.nft.indexOf(event.index);
    emit(state.copyWith(current: index));
  }

  changeStateImage(ChangeStateImageEvent event, Emitter<NftState> emit) async {
    final image = await event.file;
    if (image == null) {
      return;
    }
    final xfile = XFile(image.file.path);
    emit(state.copyWith(image: xfile));
  }
}
