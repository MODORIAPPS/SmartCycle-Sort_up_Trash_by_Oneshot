/*
이 코드는 SmartCycle 앱의 메인 화면에 있는
'최근 검색한 분리수거'의 그리드 뷰에 들어가는 샘플 json 데이터입니다.
*/


var express = require('express'),
  http = require('http'),
  app = express(),
  server = http.createServer(app);


  app.get('/test/trash/lately', (req,res) => {
      var sample_response = 
      ` 
      [{
      "_id":"5d8e2ddcc8762806d819b625",
      "user_email":"test@gmail.com",
      "trash_id":"1",
      "date":"2019/8/27",
      "__v":0
      },
      {
      "_id":"5d8e2ddcc8762806d819b625",
      "user_email":"test@gmail.com",
      "trash_id":"2",
      "date":"2019/8/29",
      "__v":0
      },
      {
      "_id":"5d8e2ddcc8762806d819b625",
      "user_email":"test@gmail.com",
      "trash_id":"3",
      "date":"2019/9/12",
      "__v":0
      },
      {
      "_id":"5d8e2ddcc8762806d819b625",
      "user_email":"test@gmail.com",
      "trash_id":"4",
      "date":"2019/6/12",
      "__v":0
      }]`;


      res.send(sample_response);
  });

  server.listen(8080, function () {
    console.log('Express server listening on port ' + server.address().port);
  });