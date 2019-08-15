class RclDetail {
  String mainTitle;
  String subTitle;

  String elementTitle;
  List<String> elementItems;
  String elementImage;

  String step1Content;
  String step1tip;
  String step1Image;

  String step2Content;
  String step2tip;
  String step2Image;

  String knowContent;
  List<String> knowItems;

  RclDetail(
      {this.mainTitle,
      this.subTitle,
      this.elementTitle,
      this.elementItems,
      this.elementImage,
      this.step1Content,
      this.step1tip,
      this.step1Image,
      this.step2Content,
      this.step2tip,
      this.step2Image,
      this.knowContent,
      this.knowItems});
}

List<String> sampleKnow = ["약 500년"];
List<String> sampleItems1 = ["페트병 PET", "라벨지 비닐류", "뚜껑 플라스틱"];
String sampleImage1 =
    "https://images-na.ssl-images-amazon.com/images/I/819sPu1FTJL._SL1500_.jpg";

/// for only sample
var detailItems = RclDetail(
    mainTitle: "페트병을 분리하는 방법(500ml형)",
    subTitle: "폴리에틸렌 테레프탈레이트(PET) 계",
    elementTitle: "페트병을 구성하는 요소",
    elementItems: sampleItems1,
    elementImage: sampleImage1,
    step1Content: "페트병안에 음료가 묻어있다면 모두 깨끗이 씻어내요.",
    step1tip: "물기를 모두 제거하면 더욱 좋습니다.",
    step2Content: "라벨지를 페트병으로부터 분리합니다.",
    step2tip: "찌그러트리면 더 쉽게 떼어낼 수 있어요.",
    knowContent: "페트병이 자연에서 완전히 분해되는데 까지 걸리는 시간",
    knowItems: sampleKnow);
