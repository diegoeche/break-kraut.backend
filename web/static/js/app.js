// Although ^=parent is not technically correct,
// we need to use it in order to get IE8 support.
$(document).ready(function () {
  var elements = document.querySelectorAll('[data-submit^=parent]')
  var len = elements.length
  console.info(elements);

  for (var i=0; i<len; ++i) {
    console.info(elements[i]);
    elements[i].addEventListener('click', function(event){
      var message = this.getAttribute("data-confirm")
      if(message === null || confirm(message)){
        this.parentNode.submit()
      };
      event.preventDefault()
      return false
    }, false)
  }
});
