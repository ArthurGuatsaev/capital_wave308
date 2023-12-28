import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../../import.dart';
import 'package:equatable/equatable.dart';

part 'topnft_event.dart';
part 'topnft_state.dart';

class TopNftBloc extends Bloc<TopNftEvent, TopNftState> {
  final TopNFTRepository nftRepository;
  TopNftBloc({required this.nftRepository}) : super(const TopNftState()) {
    on<GetSaveTopNFTEvent>(getSaveNft);
    on<UpdateTopNFTEvent>(updateNFT);
    on<SaveTopNFTEvent>(saveNFT);
    on<RemoveTopNFTEvent>(removeNFT);
    on<ReseteSaveTopNFTEvent>(reseteNFT);
    on<ChooseTopNFTEvent>(chooseImage);
    on<ChangeTopIndexEvent>(changeIndex);
    on<ChangeTopStateImageEvent>(changeStateImage);
    on<ChooseAditionalTopNFTEvent>(chooseAditionalImage);
    on<ChangeTopStateAditionalImageEvent>(changeStateAditionalImage);
  }

  getSaveNft(GetSaveTopNFTEvent event, Emitter<TopNftState> emit) {
    final nft = nftRepository.nft;
    emit(state.copyWith(topNft: nft));
  }

  updateNFT(UpdateTopNFTEvent event, Emitter<TopNftState> emit) async {
    final nft = await nftRepository.getSaveNFT();
    emit(state.copyWith(topNft: nft, image: null, aditionalImage: []));
  }

  saveNFT(SaveTopNFTEvent event, Emitter<TopNftState> emit) async {
    await nftRepository.saveImage(
        image: state.image, key: '${event.model.myId!}');
    if (event.update == null) {
      await nftRepository.saveAditionalImage(
          image: state.aditionalImage, key: '${event.model.myId!}');
    }
    await nftRepository.saveNFT(note: event.model);
    add(UpdateTopNFTEvent());
  }

  removeNFT(RemoveTopNFTEvent event, Emitter<TopNftState> emit) async {
    await nftRepository.deleteNFT(event.model);
    add(UpdateTopNFTEvent());
  }

  reseteNFT(ReseteSaveTopNFTEvent event, Emitter<TopNftState> emit) async {
    await nftRepository.reseteNFT();
    add(UpdateTopNFTEvent());
  }

  chooseImage(ChooseTopNFTEvent event, Emitter<TopNftState> emit) async {
    final image = await nftRepository.getNewImage();
    emit(state.copyWith(image: image));
  }

  chooseAditionalImage(
      ChooseAditionalTopNFTEvent event, Emitter<TopNftState> emit) async {
    final image = await nftRepository.getNewImage();
    final images = [...state.aditionalImage, image];
    emit(state.copyWithImage(aditionalImage: images));
  }

  changeIndex(ChangeTopIndexEvent event, Emitter<TopNftState> emit) async {
    final index = state.topNft.indexOf(event.index);
    emit(state.copyWith(current: index));
  }

  changeStateImage(
      ChangeTopStateImageEvent event, Emitter<TopNftState> emit) async {
    final image = await event.file;
    if (image == null) {
      return;
    }
    final xfile = XFile(image.file.path);
    emit(state.copyWith(image: xfile));
  }

  changeStateAditionalImage(ChangeTopStateAditionalImageEvent event,
      Emitter<TopNftState> emit) async {
    final image = await event.file;
    if (image == null) {
      return;
    }
    final xfiles = image.map((img) => XFile(img.file.path)).toList();
    emit(state.copyWith(aditionalImage: xfiles));
  }
}
