$(document).ready(function() {

  var origin,
      destination,
      departDate,
      returnDate,
      adultCount = 1,
      childCount = 0,
      maxStops = 0,
      preferredCabin = "COACH",
      permittedCarrier = "",
      prohibitedCarrier = "",
      solutions = 1;

  $("#search-input").submit(function(e) {
    e.preventDefault();
    origin = $("#origin").val();
    destination = $("#destination").val();
    departDate = $("#departDate").val();
    returnDate = $("returnDate").val();
    adultCount = parseInt($("#adultCount").val(), 10);
    childCount = parseInt($("#childCount").val(), 10);
    maxStops = parseInt($("#maxStops").val(), 10);
    preferredCabin = $("#preferredCabin").val();
    permittedCarrier = $("#permittedCarrier").val();
    prohibitedCarrier = prohibitedCarrier;
    solutions = parseInt($("#solutions").val(), 10);
    startAPICall();
  });

  function startAPICall() {
    reqBody = {
      "request": {
        "passengers": {
          "kind": "qpxexpress#passengerCounts",
          "adultCount": adultCount,
          "childCount": childCount,
          // "infantInLapCount": 0,
          // "infantInSeatCount": 0,
          // "seniorCount": 0
        },
        "slice": [
          {
            "kind": "qpxexpress#sliceInput",
            "origin": origin,
            "destination": destination,
            "date": departDate,
            "maxStops": maxStops,
            "maxConnectionDuration": 0,
            "preferredCabin": preferredCabin,
            "permittedDepartureTime": {
              "kind": "qpxexpress#timeOfDayRange",
              "earliestTime": "00:00",
              "latestTime": "11:59"
            },
            "permittedCarrier": [
              permittedCarrier
            ],
            "alliance": "",
            "prohibitedCarrier": [
              prohibitedCarrier
            ]
          }
        ],
        "maxPrice": "USD3000.00",
        // "saleCountry": "US",
        "refundable": false,
        "solutions": solutions
      }
    };
    $.ajax({
      url: '/search',
      dataType: 'json',
      method: 'POST',
      // contentType: "application/json; charset=utf-8",
      data: {qpxData: JSON.stringify(reqBody)},
      success: function(data) {
        console.log(data.results.trips.tripOption);
        results = data.results.trips.tripOption;
          $("tbody").empty();
        for (var i = 0; i < results.length; i++) {
          $("tbody").append("<tr><td>" + results[i].pricing[0].baseFareTotal + "</td></tr>");
        }
      }
    });
  }

});