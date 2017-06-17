export default class RiotControlBindMixin {

    // init method is a special one which can initialize
    // the mixin when it's loaded to the tag and is not
    // accessible from the tag its mixed in
  init() {
    let self = this;

    console.log('RiotControlBindMixin:init:', self);
    self.bindHandler = (element, index, array)=>{
      riot.control.on(element.event, element.handler);
    };
    self.unbindHandler = (element, index, array)=>{
      riot.control.off(element.event, element.handler);
    };
  }
}
