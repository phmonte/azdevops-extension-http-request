var path = require('path');
var tl = require('vso-task-lib');

var echo = new tl.ToolRunner(tl.which('echo', true));

var msg = tl.getInput('msg', true);
echo.arg(msg);

var urlToRequest = tl.getPathInput('urlToRequest', false);
var timeOutRequest = tl.getPathInput('timeOutRequest', false);
var interval = tl.getPathInput('interval', false);


// will error and fail task if it doesn't exist
tl.checkPath(cwd, 'cwd');
tl.cd(cwd);

echo.exec({ failOnStdErr: false})
.then(function(code) {
    tl.exit(code);
})
.fail(function(err) {
    console.error(err.message);
    tl.debug('taskRunner fail');
    tl.exit(1);
})
