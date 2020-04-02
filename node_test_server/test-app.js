/*
이 코드는 SmartCycle 앱의 메인 화면에 있는
'최근 검색한 분리수거'의 그리드 뷰에 들어가는 샘플 json 데이터입니다.
*/


var express = require('express'),
  http = require('http'),
  app = express(),
  fs = require('fs')
  server = http.createServer(app);


  app.get('/test/trash/lately', (req,res) => {
      var sample_response = 
      ` 
      [
       {
         "id":"0",
         "user_email":"test@gmail.com",
         "trash_id":"0",
         "date":"2020년 3월 4일",
         "imageURL":"https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg"

       },
       {
         "id":"1",
         "user_email":"test@gmail.com",
         "trash_id":"1",
         "date":"2020년 3월 5일",
         "imageURL":"https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg"

       },
       {
         "id":"2",
         "user_email":"test@gmail.com",
         "trash_id":"3",
         "date":"2020년 3년 6일",
         "imageURL":"https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg"

       }
      ]`;


      res.send(sample_response);
  });


  // // 유저 정보 반환 
  // // https://www.googleapis.com/plus/v1/people/${userId}?access_token=${access_token}
  // app.get('/test/getUserProfile', (req,res) => {
  //   var sample_response = 
  //   `
  //   {
  //     "kind": "plus#person",
  //     "etag": "testtestetstetstestsetsetsetsetset",
  //     "emails": [
  //      {
  //       "value": "onlyForTest@gmail.com",
  //       "type": "account"
  //      }
  //     ],
  //     "id": "1234567891234567892345678",
  //     "displayName": "John Test",
  //     "name": {
  //      "familyName": "John",
  //      "givenName": "Test"
  //     },
  //     "image": {
  //      "url": "https://lh4.googleusercontent.com/-gIFlzKZEXEw/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rcRTfcpAQibQgUYo5knMnfZ_o9qug/s50/photo.jpg",
  //      "isDefault": true
  //     },
  //     "language": "ko"
  //    }
  //    `;


  //   res.send(sample_response);
  // });



  // 알고 계셨나요? 탭 정보 반환
  app.get('/test/getDoYouKnowInfo', (req,res) => {
  
    var sample_response = 
    `
    [
      {
        "contents": [
                  {
                    "secTitle": "샘플1",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "국가는 균형있는 국민경제의 성장 및 안정과 적정한 소득의 분배를 유지하고, 시장의 지배와 경제력의 남용을 방지하며, 경제주체간의 조화를 통한 경제의 민주화를 위하여 경제에 관한 규제와 조정을 할 수 있다."
                  },
                  {
                    "secTitle": "샘플2",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "대통령은 제4항과 제5항의 규정에 의하여 확정된 법률을 지체없이 공포하여야 한다. 제5항에 의하여 법률이 확정된 후 또는 제4항에 의한 확정법률이 정부에 이송된 후 5일 이내에 대통령이 공포하지 아니할 때에는 국회의장이 이를 공포한다."
                  },
                  {
                    "secTitle": "샘플3",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "국회는 의장 1인과 부의장 2인을 선출한다. 대법관은 대법원장의 제청으로 국회의 동의를 얻어 대통령이 임명한다. 대통령은 내란 또는 외환의 죄를 범한 경우를 제외하고는 재직중 형사상의 소추를 받지 아니한다."
                  },
                  {
                    "secTitle": "샘플4",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "대법원과 각급법원의 조직은 법률로 정한다. 광물 기타 중요한 지하자원·수산자원·수력과 경제상 이용할 수 있는 자연력은 법률이 정하는 바에 의하여 일정한 기간 그 채취·개발 또는 이용을 특허할 수 있다."
                  },
                  {
                    "secTitle": "So what, 신경안써",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "국가는 농수산물의 수급균형과 유통구조의 개선에 노력하여 가격안정을 도모함으로써 농·어민의 이익을 보호한다. 대통령은 법률이 정하는 바에 의하여 사면·감형 또는 복권을 명할 수 있다."
                  },
                  {
                    "secTitle": "샘플6",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "혹시 뚜껑도 그냥 플라스틱에?"
                  }
                ],
        "_id": "5d88e78801095013472af4d8",
        "published_date": "2019-09-23T15:40:56.523Z",
        "docNum": "1",
        "title": "아니 정말 이렇게나 오래걸린다고?",
        "readTime": 4,
        "preImage": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
        "__v": 0
      },
      {
        "contents": [
                  {
                    "secTitle": "샘플1",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "국가는 균형있는 국민경제의 성장 및 안정과 적정한 소득의 분배를 유지하고, 시장의 지배와 경제력의 남용을 방지하며, 경제주체간의 조화를 통한 경제의 민주화를 위하여 경제에 관한 규제와 조정을 할 수 있다."
                  },
                  {
                    "secTitle": "샘플2",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "대통령은 제4항과 제5항의 규정에 의하여 확정된 법률을 지체없이 공포하여야 한다. 제5항에 의하여 법률이 확정된 후 또는 제4항에 의한 확정법률이 정부에 이송된 후 5일 이내에 대통령이 공포하지 아니할 때에는 국회의장이 이를 공포한다."
                  },
                  {
                    "secTitle": "샘플3",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "국회는 의장 1인과 부의장 2인을 선출한다. 대법관은 대법원장의 제청으로 국회의 동의를 얻어 대통령이 임명한다. 대통령은 내란 또는 외환의 죄를 범한 경우를 제외하고는 재직중 형사상의 소추를 받지 아니한다."
                  },
                  {
                    "secTitle": "샘플4",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "대법원과 각급법원의 조직은 법률로 정한다. 광물 기타 중요한 지하자원·수산자원·수력과 경제상 이용할 수 있는 자연력은 법률이 정하는 바에 의하여 일정한 기간 그 채취·개발 또는 이용을 특허할 수 있다."
                  },
                  {
                    "secTitle": "So what, 신경안써",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "국가는 농수산물의 수급균형과 유통구조의 개선에 노력하여 가격안정을 도모함으로써 농·어민의 이익을 보호한다. 대통령은 법률이 정하는 바에 의하여 사면·감형 또는 복권을 명할 수 있다."
                  },
                  {
                    "secTitle": "샘플6",
                    "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                    "secContent": "혹시 뚜껑도 그냥 플라스틱에?"
                  }
                ],
        "_id": "5d88e78801095013472af4d8",
        "published_date": "2019-09-23T15:40:56.523Z",
        "docNum": "2",
        "title": "이렇게 하면 분리수거를 할 수 없어요! TOP5",
        "readTime": 4,
        "preImage": "https://images.unsplash.com/photo-1547671916-8dfb17579d01?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80",
        "__v": 0
      },
      {
        "contents": [
          {
            "secTitle": "샘플1",
            "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
            "secContent": "국가는 균형있는 국민경제의 성장 및 안정과 적정한 소득의 분배를 유지하고, 시장의 지배와 경제력의 남용을 방지하며, 경제주체간의 조화를 통한 경제의 민주화를 위하여 경제에 관한 규제와 조정을 할 수 있다."
          },
          {
            "secTitle": "샘플2",
            "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
            "secContent": "대통령은 제4항과 제5항의 규정에 의하여 확정된 법률을 지체없이 공포하여야 한다. 제5항에 의하여 법률이 확정된 후 또는 제4항에 의한 확정법률이 정부에 이송된 후 5일 이내에 대통령이 공포하지 아니할 때에는 국회의장이 이를 공포한다."
          },
          {
            "secTitle": "샘플3",
            "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
            "secContent": "국회는 의장 1인과 부의장 2인을 선출한다. 대법관은 대법원장의 제청으로 국회의 동의를 얻어 대통령이 임명한다. 대통령은 내란 또는 외환의 죄를 범한 경우를 제외하고는 재직중 형사상의 소추를 받지 아니한다."
          },
          {
            "secTitle": "샘플4",
            "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
            "secContent": "대법원과 각급법원의 조직은 법률로 정한다. 광물 기타 중요한 지하자원·수산자원·수력과 경제상 이용할 수 있는 자연력은 법률이 정하는 바에 의하여 일정한 기간 그 채취·개발 또는 이용을 특허할 수 있다."
          },
          {
            "secTitle": "So what, 신경안써",
            "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
            "secContent": "국가는 농수산물의 수급균형과 유통구조의 개선에 노력하여 가격안정을 도모함으로써 농·어민의 이익을 보호한다. 대통령은 법률이 정하는 바에 의하여 사면·감형 또는 복권을 명할 수 있다."
          },
          {
            "secTitle": "샘플6",
            "image": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에?"
          }
        ],
        "_id": "5d88e78801095013472af4d8",
        "published_date": "2019-09-23T15:40:56.523Z",
        "docNum": "3",
        "title": "마스크는 어떻게 분리수거 해야할까요?",
        "readTime": 4,
        "preImage": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
        "__v": 0
      }
    ]
     `;

    res.send(sample_response);
  });


  app.get('/test/getRclDetail', (req,res) => {
  
    var sample_response = 
    `
    [
      {
          "information": {
              "composition": [
                  {
                      "part": "종이팩",
                      "value": "종이류"
                  }
              ],
              "step": [
                  {
                      "imageURL_step": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                      "contents": "부피를 줄이기 위해 납작하게 구겨 주세요."
                  },
                  {
                      "imageURL_step": "https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg",
                      "contents": "종이류에 분리 배출해 주세요. 만약 종이팩 수거함이 별도로 있다면 종이팩 수거함에 분리 배출해 주세요. 종이팩의 재활용률을 엄청나게 높일 수 있답니다."
                  }
              ],
              "compo_number": 1,
              "step_number": 2,
              "time_rot": "3개월"
          },
          "_id": "5d8b6e2579ff2107e3f95757",
          "published_date": "2019-09-25T13:39:49.822Z",
          "id": "1",
          "name": "종이팩",
          "imageURL": "/1/1_0.jpg",
          "nugu_script": "종이팩은 부피를 줄이기 위해 납작하게 구겨 주신 후 종이류에 분리 배출 해 주세요. 종이팩 수거함이 별도로 있다면 종이팩 수거함에 분리 배출해 주세요.",
          "__v": 0
      }
  ]
     `;


    res.send(sample_response);
  });


  app.get('/test/imageTest', (req,res) => {

    res.end('https://cdn.pixabay.com/photo/2020/03/12/17/33/wash-hands-4925790_960_720.jpg');


  });




  





  

  server.listen(8080, function () {
    console.log('Express server listening on port ' + server.address().port);
  });

