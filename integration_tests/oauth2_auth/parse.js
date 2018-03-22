// Read Synchrously
var fs = require("fs");
var contents = fs.readFileSync("/tmp/k1.json");
//console.log("Output Content : \n"+ contents);
// Define to JSON type
 var jsonContent = JSON.parse(contents);
// Get Value from JSON
 //console.log("data", jsonContent.data);

 //console.log("data[0]", jsonContent.data[0]);

 console.log(jsonContent.data[0]['config']['provision_key']);

