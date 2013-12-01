$(document).ready(function(){
  var button = $('#btn');
  var output = document.getElementById("result");
  button.on('click', function(){
    var original = $('#original').val();
    var revised = $('#revised').val();
    var diff = window.compare(original, revised);
    output.innerHTML = "<br/>Implied edits in going from your first to your revised text:<br/><br/>" + compare(original, revised);
  })
})