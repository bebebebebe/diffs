
function Versions(original, revised) {
  this.original = original;
  this.revised = revised;

  this.lcs = function(i, j){
    i = typeof i !== 'undefined' ? i : 0;
    j = typeof j !== 'undefined' ? j : 0;
    if (i >= original.length || j >= revised.length){
      return [];
    }
    if (original[i] == revised[j]){
      var array = this.lcs(i+1, j+1);
      array.unshift([i,j]);
      return array
    } else {
      var seq1 = this.lcs(i+1, j);
      var seq2 = this.lcs(i, j+1);
      if (seq1.length >= seq2.length){
        return seq1;
      } else {
        return seq2;
      }
    }
  };

  deleted = function(text){
    return '<span class="del"><strike>' + text + '</strike></span>';
    };
  added = function(text){
    return '<span class="add">' + text + '</span>';
  };

  this.diff = function(matches){
    if (matches.length === 0){
      return (original.map(deleted)).concat(revised.map(added));
    } else if (matches[0][0] === 0 && matches[0][1] === 0){
        var remaining_matches = matches.slice(1).map (
          function(x){
            return [x[0]-1, x[1]-1];
          }
        );
        var v = new Versions(original.slice(1), revised.slice(1));
        var array = v.diff(remaining_matches);
        array.unshift(original[0]);
        return array;
      
    } else if (matches[0][0] === 0) {
         var remaining_matches = matches.map (
           function(x){
             return [x[0], x[1]-1];
           }
         );
        var v = new Versions(original, revised.slice(1));
        var array = v.diff(remaining_matches);
        array.unshift(added(revised[0]));
        return array;
     } 
    else {
        remaining_matches = matches.map (
          function(x){
            return [x[0]-1, x[1]];
          }
        );
        var v = new Versions(original.slice(1), revised);
        var array = v.diff(remaining_matches);
        array.unshift(deleted(original[0]));
        return array;
    }
  };
};


function WebDiff(original, revised){
  this.original = original; // original, revised are strings
  this.revised = revised;

  this.compare = function(){
    var a = original.split(' ');
    var b = revised.split(' ');
    var v = new Versions(a,b);
    var output = v.diff(v.lcs());
    return output.join(' ');
  }
  
}




  // this.longest_common_subseq = function(x,y) {
  //   x = typeof x !== 'undefined' ? x : v1.length -1;
  //   y = typeof y !== 'undefined' ? y : v2.length -1;
  //   if (this.table(x,y) === 0) {
  //     return [];
  //   } else if (v1[x] === v2[y]) {
  //     var array = this.longest_common_subseq(x-1, y-1);
  //     array.push([x,y]);
  //     return array;
  //   } else if (this.table(x-1, y) >= this.table(x, y-1)) {
  //     return this.longest_common_subseq(x-1, y);
  //   } else {
  //     return this.longest_common_subseq(x, y-1);
  //   }
  // };

