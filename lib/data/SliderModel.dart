class SliderModel {
  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath, this.title, this.desc});
}

List<SliderModel> getSlides() {
  return <SliderModel>[
    SliderModel(
        imagePath: "assets/images/payowners.jpeg",
        title: "Payowners",
        desc: "Hello to Payowners"),
    SliderModel(
        imagePath: "assets/images/brand_icon.png",
        title: "AfricInnovate",
        desc: "We are here to Payowners"),
    SliderModel(
        imagePath: "assets/images/payowners.jpeg",
        title: "Sheistechy",
        desc: "Welcome to Payowners")
  ];
}
