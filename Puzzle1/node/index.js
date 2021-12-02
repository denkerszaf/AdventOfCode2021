fs = require('fs'); 


	function getDepthReadings(input) { 
		result = 0; 
		for (i = 1; i<=input.length; i++) {
			if (input[i] > input[i - 1]) {
				result = result + 1;
			}
		}
		return result;
	};

module.exports = {
	getDepthReadings: getDepthReadings
};

if (require.main === module) {
	fs.readFile('../input', 'utf8', function (err, data) {
		if (err) {
			console.log(err);
		}
		else {
			console.log(getDepthReadings(data.split("\n")));
		}
	});
}
