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
        "title": "이거 정말 좋은생각입니다.",
        "readTime": 4,
        "preImage": "https://cdn.clien.net/web/api/file/F01/2045212/476b3769e6e048dfbd1.JPG",
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
        "docNum": "1",
        "title": "이거 정말 좋은생각입니다.",
        "readTime": 4,
        "preImage": "https://cdn.clien.net/web/api/file/F01/2045212/476b3769e6e048dfbd1.JPG",
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
        "docNum": "1",
        "title": "이거 정말 좋은생각입니다.",
        "readTime": 4,
        "preImage": "https://cdn.clien.net/web/api/file/F01/2045212/476b3769e6e048dfbd1.JPG",
        "__v": 0
      }
    ]
     `;


    res.send(sample_response);
  });







  

  server.listen(8080, function () {
    console.log('Express server listening on port ' + server.address().port);
  });