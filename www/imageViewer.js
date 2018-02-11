var exec = require('cordova/exec');

var ImageViewer = {
	show: function  (options, callback) {
		exec (callback, null, 'ImageViewer', 'show', [options.imageUrl, options.backgroundColor || [0,0,0]])
	}
}

module.exports = ImageViewer
