function Versions(v1, v2){
  this.v1 = v1;
  this.v2 = v2;

  // lcs_table is an array of arrays. lcs_table[x][y] is the length of 
  // the longest common subsequence of
  // the prefix of v1 up to index x and the prefix of v2 up to the index y.
  // 
  var lcs_table = [];
  while (lcs_table.length <= v2.length) {
  lcs_table.push([0]);
  }
  while (lcs_table[0].length <= v1.length){
  lcs_table[0].push(0);
  }
  for (x=1; x<=v2.length; x++){
    for (y=1; y<=v1.length; y++){
      if (v1[x-1] === v2[y-1]) {
        lcs_table[x][y] = lcs_table[x-1][y-1] + 1
      } else {
        lcs_table[x][y] = Math.max(lcs_table[x-1][y], lcs_table[x][y-1])
      }
    }
  }

  // Uses lcs_table above to construct the implied edits in going from
  // the prefix of v1 up to index x, to the prefix of v2 up to index y.
  //
  this.diff = function(x,y) {
    x = typeof x !== 'undefined' ? x : v1.length - 1;
    y = typeof y !== 'undefined' ? y : v2.length - 1;
    if (x < 0 && y < 0) {
      return [];
    } else if (y < 0) {
      var array = this.diff(x-1, y);
      array.push(Display.deleted(v1[x]));
      return array;
    } else if (x < 0) {
      var array = this.diff(x, y-1);
      array.push(Display.added(v2[y]));
      return array;
    } else if (v1[x] === v2[y]) {
      var array = this.diff(x-1, y-1);
      array.push(v1[x]);
      return array;
    } else if (lcs_table[x][y+1] >= lcs_table[x+1][y]) {
      var array = this.diff(x-1, y);
      array.push(Display.deleted(v1[x]));
      return array;
    } else {
      array = this.diff(x, y-1);
      array.push(Display.added(v2[y]));
      return array;
    }
  }

};

var Display = function(){
  return {deleted: function(text){
    return '<span class="del"><strike>' + text + '</strike></span>';
  },
  added: function(text){
    return '<span class="add">' + text + '</span>';
  }};
}();

function WebDiff(original, revised){
  this.original = original; // original, revised are strings
  this.revised = revised;

  this.compare = function(){
    var a = original.split(' ');
    var b = revised.split(' ');
    var v = new Versions(a,b);
    var output = v.diff();
    return output.join(' ');
  }
}