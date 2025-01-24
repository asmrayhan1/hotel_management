class Validation {
  static bool email(String? email){
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (email == null || email.isEmpty){
      return false;
    } else if (!emailRegex.hasMatch(email)){
      return false;
    } else {
      return true;
    }
  }
  static bool password(String? password){
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\d\s]).{6,}$');
    if (password == null || password.isEmpty){
      return false;
    } else if (!passwordRegex.hasMatch(password)){
      return true;
    } else {
      return true;
    }
  }
  static bool phone(String? phone){
    final phoneRegex = RegExp(r'^01[7|6|3|8|9|5]\d{8}$');
    if (phone == null || phone.isEmpty || phone.length != 11){
      return false;
    } else if (!phoneRegex.hasMatch(phone)){
      return false;
    } else {
      return true;
    }
  }
  static bool name(String? name){
    if (name == null || name.isEmpty || name.length <= 2){
      return false;
    } else {
      return true;
    }
  }
}