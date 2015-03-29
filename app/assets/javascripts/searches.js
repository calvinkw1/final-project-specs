$(document).ready(function() {

  $("#search-input").submit(function(e) {
    e.preventDefault();
    startAPICall();
  });

  function startAPICall() {
    var origin = $("#origin").val(),
        destination = $("#destination").val(),
        date = $("#date").val(),
        adultCount = $("#adultCount").val(),
        preferredCabin = $("#preferredCabin").val(),
        permittedCarrier = $("#permittedCarrier").val(),
        reqBody = JSON.stringify({
          "request": {
            "passengers": {
              "kind": "qpxexpress#passengerCounts",
              "adultCount": 1,
              "childCount": 0,
              "infantInLapCount": 0,
              "infantInSeatCount": 0,
              "seniorCount": 0
            },
            "slice": [
              {
                "kind": "qpxexpress#sliceInput",
                "origin": "SFO",
                "destination": "HNL",
                "date": "2015-04-03",
                "maxStops": 0,
                "maxConnectionDuration": 0,
                "preferredCabin": "COACH",
                "permittedDepartureTime": {
                  "kind": "qpxexpress#timeOfDayRange",
                  "earliestTime": "00:00",
                  "latestTime": "11:59"
                },
                "permittedCarrier": [
                  "VX",
                  "UA"
                ],
                "alliance": "",
                "prohibitedCarrier": [
                  ""
                ]
              }
            ],
            "maxPrice": "USD1000.00",
            "saleCountry": "US",
            "refundable": false,
            "solutions": 1
          }
        });
    $.ajax({
      url: '/search.json',
      method: 'POST',
      // contentType: "application/json; charset=utf-8",
      data: reqBody,
      success: function(data) {
        console.log(data);
      }
    });
  }

});