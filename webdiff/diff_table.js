function Versions(v1, v2){
  this.v1 = v1;
  this.v2 = v2;

  this.table = function(x,y) {
    if (x == -1 || y == -1) {
      return 0;
    } else if (v1[x] === v2[y]) {
      return this.table(x-1, y-1) + 1;
    } else {
      return Math.max(this.table(x-1, y), this.table(x, y-1));
    }
  };

  this.diff = function(x,y) {
    x = typeof x !== 'undefined' ? x : v1.length - 1;
    y = typeof y !== 'undefined' ? y : v2.length -1;
    if (x < 0 || y < 0) {
      return [];
    } else if (v1[x] === v2[y]) {
      var array = this.diff(x-1, y-1);
      array.push(v1[x]);
      return array;
    } else if (this.table(x-1, y) >= this.table(x, y-1)) {
      var array = this.diff(x-1, y);
      array.push(Display.deleted(v1[x]));
      return array;
    } else {
      var array = this.diff(x, y-1);
      array.push(Display.added(v2[y]));
      return array;
    }
  };

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