$(document).ready(function(){
  var button = $('#btn');
  var output = document.getElementById("result");
  button.on('click', function(){
    var original = $('#original').val();
    var revised = $('#revised').val();
    output.innerHTML="Implied edits in going from your first to your revised text:<br/><br/>" + compare(original, revised);
  })

})