class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompany() {
    return <Company>[
      Company(1, "Payowners"),
      Company(2, "AficInnovate"),
      Company(3, "Sheistechy"),
      Company(4, "Food Delivery"),
      Company(5, "Laundry"),
    ];
  }
}
