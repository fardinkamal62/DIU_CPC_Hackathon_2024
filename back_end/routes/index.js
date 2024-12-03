var express = require('express');
var router = express.Router();
const api = require('../api');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/api/schedules', function(req, res, next) {
  const schedules = api.getSchedules(req, res);
  res.json(schedules);
});

router.post('/api/event', function(req, res, next) {
  const event = api.addEvent(req, res);
  res.json(event);
});

module.exports = router;
