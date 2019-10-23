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
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해1",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해2",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해3",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해4",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해5",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          }
        ],
        "_id": "5d88e78801095013472af4d8",
        "published_date": "2019-09-23T15:40:56.523Z",
        "docNum": "1",
        "title": "설레임을 분리수거 하는 방법",
        "readTime": 4,
        "preImage": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
        "__v": 0
      },
      {
        "contents": [
          {
            "secTitle": "잘못된 오해",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해1",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해2",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해3",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해4",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해5",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          }
        ],
        "_id": "5d88e78801095013472af4d8",
        "published_date": "2019-09-23T15:40:56.523Z",
        "docNum": "1",
        "title": "귀여운 상욱이에 대하여",
        "readTime": 4,
        "preImage": "http://blog.coursemos.kr/wp-content/uploads/2019/08/487215_145614_4922-860x423.jpg",
        "__v": 0
      },
      {
        "contents": [
          {
            "secTitle": "잘못된 오해",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해1",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해2",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해3",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해4",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해5",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          }
        ],
        "_id": "5d88e78801095013472af4d8",
        "published_date": "2019-09-23T15:40:56.523Z",
        "docNum": "1",
        "title": "사실 이것은 신승민 군입니다만",
        "readTime": 4,
        "preImage": "http://www.jobnjoy.com/files/editor/1489453572220_1.jpg",
        "__v": 0
      },
      {
        "contents": [
          {
            "secTitle": "잘못된 오해",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해1",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해2",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해3",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해4",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          },
          {
            "secTitle": "잘못된 오해5",
            "image": "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwibx-638rDkAhWUH3AKHZkQBp8QjRx6BAgBEAQ&url=https%3A%2F%2Fdoumiangel.tistory.com%2F10&psig=AOvVaw3wrKi8f9CirXDNK4a7t06Q&ust=1567470936195220",
            "secContent": "혹시 뚜껑도 그냥 플라스틱에 넣으면 되지 않을까?"
          }
        ],
        "_id": "5d88e78801095013472af4d8",
        "published_date": "2019-09-23T15:40:56.523Z",
        "docNum": "1",
        "title": "사랑스러운 그는 빌리",
        "readTime": 4,
        "preImage": "http://getnews.jp/img/archives/dsc_7974-225x300.jpg",
        "__v": 0
      }
    ]
     `;


    res.send(sample_response);
  });







  

  server.listen(8080, function () {
    console.log('Express server listening on port ' + server.address().port);
  });