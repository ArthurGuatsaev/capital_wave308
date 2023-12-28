// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'topnft_bloc.dart';

class TopNftState {
  final List<TopNFTModel> topNft;
  final XFile? image;
  final List<XFile?> aditionalImage;
  final int current;
  final int currentFavorite;
  const TopNftState(
      {this.topNft = const [],
      this.current = 0,
      this.aditionalImage = const [],
      this.currentFavorite = 0,
      this.image});

  TopNftState copyWith({
    List<TopNFTModel>? topNft,
    List<XFile?>? aditionalImage,
    int? current,
    int? currentFavorite,
    XFile? image,
  }) {
    return TopNftState(
      aditionalImage: aditionalImage ?? this.aditionalImage,
      image: image,
      topNft: topNft ?? this.topNft,
      current: current ?? this.current,
      currentFavorite: currentFavorite ?? this.currentFavorite,
    );
  }

  TopNftState copyWithImage({
    List<XFile?>? aditionalImage,
  }) {
    return TopNftState(
      aditionalImage: aditionalImage ?? this.aditionalImage,
      image: image,
      topNft: topNft,
      current: current,
      currentFavorite: currentFavorite,
    );
  }
}
