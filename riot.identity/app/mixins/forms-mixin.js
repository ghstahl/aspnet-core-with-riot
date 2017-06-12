export default class FormsMixin {

    // init method is a special one which can initialize
    // the mixin when it's loaded to the tag and is not
    // accessible from the tag its mixed in
  init() {
    let self = this;

    console.log('FormsMixin:init:', self);
    self.toJSONString = (form) =>{
      let obj = {};
      let elements = form.querySelectorAll('input, select, textarea');

      for (let i = 0; i < elements.length; ++i) {
        let element = elements[i];
        let name = element.name;
        let value = element.value;

        if (name) {
          obj[ name ] = value;
        }
      }

      return JSON.stringify(obj);
    };

  }
}

