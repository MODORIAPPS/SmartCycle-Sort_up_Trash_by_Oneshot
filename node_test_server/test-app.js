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
            "secTitle": "잘못된 오해",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "국가는 균형있는 국민경제의 성장 및 안정과 적정한 소득의 분배를 유지하고, 시장의 지배와 경제력의 남용을 방지하며, 경제주체간의 조화를 통한 경제의 민주화를 위하여 경제에 관한 규제와 조정을 할 수 있다."
          },
          {
            "secTitle": "間違い誤解",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "대통령은 제4항과 제5항의 규정에 의하여 확정된 법률을 지체없이 공포하여야 한다. 제5항에 의하여 법률이 확정된 후 또는 제4항에 의한 확정법률이 정부에 이송된 후 5일 이내에 대통령이 공포하지 아니할 때에는 국회의장이 이를 공포한다."
          },
          {
            "secTitle": "知らなかった情報",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "국회는 의장 1인과 부의장 2인을 선출한다. 대법관은 대법원장의 제청으로 국회의 동의를 얻어 대통령이 임명한다. 대통령은 내란 또는 외환의 죄를 범한 경우를 제외하고는 재직중 형사상의 소추를 받지 아니한다."
          },
          {
            "secTitle": "What I have not know",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "대법원과 각급법원의 조직은 법률로 정한다. 광물 기타 중요한 지하자원·수산자원·수력과 경제상 이용할 수 있는 자연력은 법률이 정하는 바에 의하여 일정한 기간 그 채취·개발 또는 이용을 특허할 수 있다."
          },
          {
            "secTitle": "So what, 신경안써",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "국가는 농수산물의 수급균형과 유통구조의 개선에 노력하여 가격안정을 도모함으로써 농·어민의 이익을 보호한다. 대통령은 법률이 정하는 바에 의하여 사면·감형 또는 복권을 명할 수 있다."
          },
          {
            "secTitle": "共产党万岁",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          }
        ],
        "_id": "5d88e78801095013472af4d8",
        "published_date": "2019-09-23T15:40:56.523Z",
        "docNum": "1",
        "title": "Toyota prius",
        "readTime": 4,
        "preImage": "https://st.motortrend.com/uploads/sites/10/2017/12/2018-toyota-prius-three-touring-hatchback-angular-rear.png",
        "__v": 0
      },
      {
        "contents": [
          {
            "secTitle": "잘못된 오해",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "국가는 균형있는 국민경제의 성장 및 안정과 적정한 소득의 분배를 유지하고, 시장의 지배와 경제력의 남용을 방지하며, 경제주체간의 조화를 통한 경제의 민주화를 위하여 경제에 관한 규제와 조정을 할 수 있다."
          },
          {
            "secTitle": "間違い誤解",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "대통령은 제4항과 제5항의 규정에 의하여 확정된 법률을 지체없이 공포하여야 한다. 제5항에 의하여 법률이 확정된 후 또는 제4항에 의한 확정법률이 정부에 이송된 후 5일 이내에 대통령이 공포하지 아니할 때에는 국회의장이 이를 공포한다."
          },
          {
            "secTitle": "知らなかった情報",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "국회는 의장 1인과 부의장 2인을 선출한다. 대법관은 대법원장의 제청으로 국회의 동의를 얻어 대통령이 임명한다. 대통령은 내란 또는 외환의 죄를 범한 경우를 제외하고는 재직중 형사상의 소추를 받지 아니한다."
          },
          {
            "secTitle": "What I have not know",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "대법원과 각급법원의 조직은 법률로 정한다. 광물 기타 중요한 지하자원·수산자원·수력과 경제상 이용할 수 있는 자연력은 법률이 정하는 바에 의하여 일정한 기간 그 채취·개발 또는 이용을 특허할 수 있다."
          },
          {
            "secTitle": "So what, 신경안써",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "국가는 농수산물의 수급균형과 유통구조의 개선에 노력하여 가격안정을 도모함으로써 농·어민의 이익을 보호한다. 대통령은 법률이 정하는 바에 의하여 사면·감형 또는 복권을 명할 수 있다."
          },
          {
            "secTitle": "共产党万岁",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
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
            "secTitle": "열심히 활동을 하는 준서군의 모습",
            "image": "https://scontent-icn1-1.xx.fbcdn.net/v/t1.0-9/66588716_1013274908877658_3008250271563251712_o.jpg?_nc_cat=110&_nc_oc=AQmrJXnCd9xaBdrir9fkF67K9vCkbgVnGWJVQCeAYKrQg7cvt4BqpRZtJQbNki9jYJo&_nc_ht=scontent-icn1-1.xx&oh=57ca7e4e977c1bfd77a3eef6354d58ae&oe=5E24BC1E",
            "secContent": "국가는 균형있는 국민경제의 성장 및 안정과 적정한 소득의 분배를 유지하고, 시장의 지배와 경제력의 남용을 방지하며, 경제주체간의 조화를 통한 경제의 민주화를 위하여 경제에 관한 규제와 조정을 할 수 있다."
          },
          {
            "secTitle": "혜원",
            "image": "https://scontent-icn1-1.xx.fbcdn.net/v/t1.0-9/66514153_1013274805544335_9113394069186281472_o.jpg?_nc_cat=102&_nc_oc=AQnHNDl9CwwHNGsPj_aXWk6--ATMeJdOtIMeYMAicF957ZOK573XMBwvTXLjOueHyYc&_nc_ht=scontent-icn1-1.xx&oh=f1a3073c9faf166b362106a5d5bfb40c&oe=5E259D7E",
            "secContent": "대통령은 제4항과 제5항의 규정에 의하여 확정된 법률을 지체없이 공포하여야 한다. 제5항에 의하여 법률이 확정된 후 또는 제4항에 의한 확정법률이 정부에 이송된 후 5일 이내에 대통령이 공포하지 아니할 때에는 국회의장이 이를 공포한다."
          },
          {
            "secTitle": "냥냥이",
            "image": "https://scontent-icn1-1.xx.fbcdn.net/v/t1.0-9/66218713_1013274812211001_5413625144952225792_o.jpg?_nc_cat=101&_nc_oc=AQmk2c9j3GM4XtNArqphaYUNb95UQAY6Xm_cSh2KFnxlOlTXODBm1YbcbUlX_xgW-wo&_nc_ht=scontent-icn1-1.xx&oh=141474426a7fb0dfadfbffa47caeb8ce&oe=5E26B1E6",
            "secContent": "국회는 의장 1인과 부의장 2인을 선출한다. 대법관은 대법원장의 제청으로 국회의 동의를 얻어 대통령이 임명한다. 대통령은 내란 또는 외환의 죄를 범한 경우를 제외하고는 재직중 형사상의 소추를 받지 아니한다."
          },
          {
            "secTitle": "코드베이커리 전원이 사진을 촬영하였습니다.",
            "image": "https://scontent-icn1-1.xx.fbcdn.net/v/t1.0-9/66498316_1013273685544447_2330891511887036416_o.jpg?_nc_cat=109&_nc_oc=AQmUO1npmipOpfFNM0cpeEQMhf6uzmTcMEyaIjq4HJgU8So3sSdfA_Cck8X4noe-MHQ&_nc_ht=scontent-icn1-1.xx&oh=28076300727e28f0d2ca9a7e0edffb2e&oe=5E17895C",
            "secContent": "대법원과 각급법원의 조직은 법률로 정한다. 광물 기타 중요한 지하자원·수산자원·수력과 경제상 이용할 수 있는 자연력은 법률이 정하는 바에 의하여 일정한 기간 그 채취·개발 또는 이용을 특허할 수 있다."
          },
          {
            "secTitle": "So what, 신경안써",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "국가는 농수산물의 수급균형과 유통구조의 개선에 노력하여 가격안정을 도모함으로써 농·어민의 이익을 보호한다. 대통령은 법률이 정하는 바에 의하여 사면·감형 또는 복권을 명할 수 있다."
          },
          {
            "secTitle": "共产党万岁",
            "image": "https://www.googlse.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          }
        ],
        "_id": "5d88e78801095013472af4d8",
        "published_date": "2019-09-23T15:40:56.523Z",
        "docNum": "3",
        "title": "준성군이 이야기하는 대한민국의 교육산업의 미래 ",
        "readTime": 4,
        "preImage": "https://scontent-icn1-1.xx.fbcdn.net/v/t1.0-9/66413473_1013273212211161_8262834469761712128_o.jpg?_nc_cat=107&_nc_oc=AQkuS7cFQYDnymTen_Qa35dhNWXJn2k1quxjrd_0DlvsGyCu1ADxu0x_BlZJv3XmqF0&_nc_ht=scontent-icn1-1.xx&oh=1ba1dcb1c6275bfa24eae4de08e67f97&oe=5E5FE972",
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
                      "imageURL_step": "https://cdn.pixabay.com/photo/2020/02/04/22/29/owl-4819550_960_720.jpg",
                      "contents": "부피를 줄이기 위해 납작하게 구겨 주세요."
                  },
                  {
                      "imageURL_step": "https://cdn.pixabay.com/photo/2020/02/04/22/29/owl-4819550_960_720.jpg",
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

    res.end('https://5.imimg.com/data5/ET/FM/MY-11874215/1-litre-pet-bottle-500x500.jpg');


  });




  





  

  server.listen(8080, function () {
    console.log('Express server listening on port ' + server.address().port);
  });

