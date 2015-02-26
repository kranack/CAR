var express = require('express');
var router = express.Router();


router.get('/', function(req, res, next) {
    res.send('request for all files');
});

router.get('/:filename', function(req, res, next) {
    res.render('files', {title: 'Files', action: 'get', file: req.params.filename});
});

router.put('/:filename', function(req, res, next) {
    res.render('files', {title: 'Files', action: 'put', file: req.params.filename});
});

router.delete('/:filename', function(req, res, next) {
    res.render('files', {title: 'Files', action: 'delete', file: req.params.filename});
});

module.exports = router;
