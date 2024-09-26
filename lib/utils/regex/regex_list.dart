  class RegexList {
    static final RegExp nameRegEx = RegExp(r"^[a-zA-ZÀ-ÿ]+(?:[-' ][a-zA-ZÀ-ÿ]+)*$");
    static final RegExp passwordRegEx = RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    static final RegExp emailRegEx = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  }
  
