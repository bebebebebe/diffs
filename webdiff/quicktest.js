// run with: $ node quicktests.js
// if no errors printed, the test passed

var d = require('./diff_table');
var assert = require('assert');

assert.equal(new d.WebDiff("ab", "abc").compare(),
             "<span class=\"add\">abc</span> <span class=\"del\"><strike>ab</strike></span>");
