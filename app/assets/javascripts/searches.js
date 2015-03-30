$(document).ready(function() {

  var origin,
      destination,
      departDate,
      returnDate,
      adultCount = 1,
      childCount = 0,
      maxStops = 0,
      preferredCabin = "COACH",
      permittedCarrier = [""],
      prohibitedCarrier = [""];

  $("#search-input").submit(function(e) {
    e.preventDefault();
    origin = $("#origin").val().toUpperCase();
    destination = $("#destination").val().toUpperCase();
    departDate = $("#departDate").val();
    returnDate = $("returnDate").val();
    adultCount = parseInt($("#adultCount").val(), 10);
    childCount = parseInt($("#childCount").val(), 10);
    maxStops = parseInt($("#maxStops").val(), 10);
    preferredCabin = $("#preferredCabin").val().toUpperCase();
    permittedCarrier = $("#permittedCarrier").val().toUpperCase().split(",");
    prohibitedCarrier = prohibitedCarrier;
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
              "earliestTime": "",
              "latestTime": ""
            },
            "permittedCarrier": permittedCarrier,
            "alliance": "",
            "prohibitedCarrier": prohibitedCarrier
          }
        ],
        "maxPrice": "USD3000.00",
        // "saleCountry": "US",
        "refundable": false,
        "solutions": 500
      }
    };
    $.ajax({
      url: '/search',
      dataType: 'json',
      method: 'POST',
      // contentType: "application/json; charset=utf-8",
      data: {qpxData: JSON.stringify(reqBody)},
      success: function(data) {
        $(".results").show();
        console.log(data);
        results = data.results.trips.tripOption;
        flightData = data.results.trips.data;
          $("tbody").empty();
        for (var i = 0; i < results.length; i++) {
          $("tbody").append("<tr id='result-row" + i + "'>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].origin + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].destination + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].departureTime + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].arrivalTime + "</td>");
          $("#result-row" + i).append("<td>" + results[i].pricing[0].passengers.adultCount + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].cabin + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].flight.carrier + " " + results[i].slice[0].segment[0].flight.number + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].aircraft + "</td>");
          $("#result-row" + i).append("<td>" + results[i].pricing[0].baseFareTotal + "</td>");
          $("#result-row" + i).append("<td>" + results[i].pricing[0].saleTaxTotal + "</td>");
          $("#result-row" + i).append("<td>" + results[i].pricing[0].saleTotal + "</td>");

        }
      }
    });
  }

});