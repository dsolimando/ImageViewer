var exec = require('cordova/exec');

var ImageViewer = {
	show: function  (imageUrl, callback) {
		exec (callback, null, 'ImageViewer', 'show', [imageUrl])
	}
}

module.exports = ImageViewer