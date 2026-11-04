'use strict';

const express = require('express');
const app = express();

/* ============================
   Exercise 1: Splendid Circles
   Endpoint: /math/circle/:r
   ============================ */
app.get('/math/circle/:r', function(req, res) {
  let r = Number(req.params.r);

  // If radius is not a number
  if (isNaN(r)) {
    return res
      .type('text')
      .status(400)
      .send('Error: radius must be a number.');
  }

  let area = Math.PI * r * r;
  let circumference = Math.PI * 2 * r;

  res.json({
    area: area,
    circumference: circumference
  });
});

/* ============================
   Exercise 2: Hello, you!
   Endpoint: /hello/name?first=&last=
   ============================ */
app.get('/hello/name', function(req, res) {
  let first = req.query.first;
  let last = req.query.last;

  let missing = [];

  if (!first) missing.push('first');
  if (!last) missing.push('last');

  if (missing.length > 0) {
    return res
      .type('text')
      .status(400)
      .send('Missing Required GET parameters: ' + missing.join(', '));
  }

  res.type('text');
  res.send(`Hello ${first} ${last}`);
});

/* ============================
   Server Setup
   ============================ */
const PORT = process.env.PORT || 8000;
app.listen(PORT);
