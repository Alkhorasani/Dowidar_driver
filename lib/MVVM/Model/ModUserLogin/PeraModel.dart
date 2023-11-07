class ParametrizedLoginModel {
  String? prPhoneno;
  String? pr_Password;

  ParametrizedLoginModel  ({
    this.prPhoneno,
    this.pr_Password,
  });

  Map<String, dynamic> toJson() {
    return {
      'prPhoneno': prPhoneno,
      'pr_Password': pr_Password,
    };
  }
}
