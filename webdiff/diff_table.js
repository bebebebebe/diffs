;(function(exports) {

  function lcsTable(v1, v2) {
    // lcs_table is an array of arrays. For x, y > 0, lcs_table[x][y] is the length of 
    // the longest common subsequence of
    // the prefix of v1 up to index x-1 and the prefix of v2 up to the index y-1.
    // 
    var lcs_table = [];
    while (lcs_table.length <= v1.length) {
      lcs_table.push([0]);
    }
    while (lcs_table[0].length <= v2.length) {
      lcs_table[0].push(0);
    }
    for (var x=1; x<=v1.length; x++) {
      for (var y=1; y<=v2.length; y++) {
        if (v1[x-1] === v2[y-1]) {
          lcs_table[x][y] = lcs_table[x-1][y-1] + 1;
        } else {
          lcs_table[x][y] = Math.max(lcs_table[x-1][y], lcs_table[x][y-1]);
        }
      }
    }
    return lcs_table;
  }

  function diff(v1, v2) {
    var table = lcsTable(v1, v2);
    // Uses lcs_table above to construct the implied edits in going from
    // the prefix of v1 up to index x, to the prefix of v2 up to index y.
    //
    return function generateEdits(x, y) {
      x = x !== undefined ? x : v1.length - 1;
      y = y !== undefined ? y : v2.length - 1;
      if (x < 0 && y < 0) {
        return [];
      } else if (y < 0) {
        var array = generateEdits(x-1, y);
        array.push(display.deleted(v1[x]));
        return array;
      } else if (x < 0) {
        var array = generateEdits(x, y-1);
        array.push(display.added(v2[y]));
        return array;
      } else if (v1[x] === v2[y]) {
        var array = generateEdits(x-1, y-1);
        array.push(v1[x]);
        return array;
      } else if (table[x][y+1] >= table[x+1][y]) {
        var array = generateEdits(x-1, y);
        array.push(display.deleted(v1[x]));
        return array;
      } else {
        array = generateEdits(x, y-1);
        array.push(display.added(v2[y]));
        return array;
      }
    }();
  }

  var display = {
    deleted: function(text){
      return '<span class="del"><strike>' + text + '</strike></span>';
    },
    added: function(text){
      return '<span class="add">' + text + '</span>';
    }
  };

  exports.compare = function(original, revised) {
      var a = original.split(' ');
      var b = revised.split(' ');
      var output = diff(a, b);
      return output.join(' ');
  };

}(this));