'use strict';
var fs = require("fs");

//for (let j = 0; j < process.argv.length; j++) {
//    console.log(j + ' -> ' + (process.argv[j]));
//}
var jsonFile = process.argv[2];
var field = process.argv[3];
//console.log("Parse attribute:", field, " from json file:", jsonFile);

var contents = fs.readFileSync(jsonFile);
//console.log("File Content : \n" + contents);

var jsonContent = JSON.parse(contents);
var value = jsonContent[field];
console.log(value);

