// run with: $ node quicktests.js
// if no errors printed, the test passed

var diff = require('./diff_table');
var assert = require('assert');

assert.equal(diff.compare("ab", "abc"),
             "<span class=\"add\">abc</span> <span class=\"del\"><strike>ab</strike></span>");
