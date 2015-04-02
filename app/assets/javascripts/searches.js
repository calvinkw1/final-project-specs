$(document).ready(function() {

  var uid,
      origin,
      destination,
      departDate,
      returnDate,
      adultCount = 1,
      childCount = 0,
      maxPrice = 0,
      maxStops = 0,
      preferredCabin = "",
      permittedCarrier = "",
      prohibitedCarrier = "",
      searchObjSave;


  $("#search-input").submit(function(e) {
    e.preventDefault();
    uid = $("#uid").val();
    origin = $("#origin").val().toUpperCase();
    destination = $("#destination").val().toUpperCase();
    departDate = $("#departDate").val();
    returnDate = $("#returnDate").val();
    adultCount = parseInt($("#adultCount").val(), 10);
    childCount = parseInt($("#childCount").val(), 10);
    maxPrice = "USD" + $("#maxPrice").val() + ".00";
    maxStops = parseInt($("#maxStops").val(), 10);
    preferredCabin = $("#preferredCabin").val().toUpperCase();
    permittedCarrier = $("#permittedCarrier").val().toUpperCase();
    prohibitedCarrier = prohibitedCarrier;
    startAPICall();
  });


  function startAPICall() {
    $("#loading").show();
    var reqBody = {
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
            "permittedCarrier": [permittedCarrier],
            "alliance": "",
            "prohibitedCarrier": [prohibitedCarrier]
          },
          {
            "kind": "qpxexpress#sliceInput",
            "origin": destination,
            "destination": origin,
            "date": returnDate,
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
        "maxPrice": maxPrice,
        // "saleCountry": "US",
        "refundable": false,
        "solutions": 500
      }
    };
    searchObjSave = reqBody;
    $.ajax({
      url: '/search',
      dataType: 'json',
      method: 'POST',
      // contentType: "application/json; charset=utf-8",
      data: {qpxData: JSON.stringify(reqBody)},
      success: function(data) {
        $("#loading").hide();
        $(".results").show();
        $("#save-search").show();
        $("#results").empty();
        console.log(data);
        results = data.results.trips.tripOption;
        flightData = data.results.trips.data;        
        for (var i = 0; i < results.length; i++) {
          // build on the below to avoid appending over and over again, and to avoid breakage from the append.
          // var out = "<tr id='result-row" + i + "'>";
          // out += "<td>" + results[i].slice[0].segment[0].leg[0].origin + "</td>";
          $("#results").append("<tr id='result-row" + i + "'>");
          // Outbound flights
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].origin + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].destination + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].departureTime + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].arrivalTime + "</td>");
          $("#result-row" + i).append("<td>" + results[i].pricing[0].passengers.adultCount + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].cabin + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].flight.carrier + " " + results[i].slice[0].segment[0].flight.number + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[0].segment[0].leg[0].aircraft + "</td>");
          // Inbound flights
          $("#result-row" + i).append("<td>" + results[i].slice[1].segment[0].leg[0].origin + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[1].segment[0].leg[0].destination + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[1].segment[0].leg[0].departureTime + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[1].segment[0].leg[0].arrivalTime + "</td>");
          $("#result-row" + i).append("<td>" + results[i].pricing[0].passengers.adultCount + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[1].segment[0].cabin + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[1].segment[0].flight.carrier + " " + results[i].slice[0].segment[0].flight.number + "</td>");
          $("#result-row" + i).append("<td>" + results[i].slice[1].segment[0].leg[0].aircraft + "</td>");
          // Fare calculation includes both Outbound and Inbound totals
          $("#result-row" + i).append("<td>" + results[i].pricing[0].baseFareTotal + "</td>");
          $("#result-row" + i).append("<td>" + results[i].pricing[0].saleTaxTotal + "</td>");
          $("#result-row" + i).append("<td>" + results[i].saleTotal + "</td>");
        }
                // $("body").scrollTo("#results");

      }
    });
  }

  $(function() {
    $(".alerts").accordion({collapsible:true});
    $(".search").accordion({collapsible:true, active: true});
  });

  $("#save").click(function(e) {
    e.preventDefault();
    console.log(searchObjSave);
    $.ajax({
      url: '/save',
      method: 'POST',
      data: {
        uid: uid,
        savedSearch: JSON.stringify(searchObjSave),
        origin: origin,
        destination: destination,
        departDate: departDate,
        returnDate: returnDate,
        adultCount: adultCount,
        childCount: childCount,
        maxPrice: maxPrice,
        preferredCabin: preferredCabin,
        permittedCarrier: permittedCarrier,
        prohibitedCarrier: prohibitedCarrier
      },
      success: function(data) {
        console.log(data);
        var html;
        html += "<tr>";
        html += "<td>Refresh to Delete</td>";
        html += "<td>" + data.origin + "</td>";
        html += "<td>" + data.destination + "</td>";
        html += "<td>" + data.departDate + "</td>";
        html += "<td>" + data.returnDate + "</td>";
        html += "<td>" + data.adultCount + "</td>";
        if (data.childCount !== "") {
          html += "<td>" + data.childCount + "</td>";
        } else {
          html += "<td></td>";
        }
        html += "<td>" + data.maxPrice + "</td>";
        if (data.preferredCabin !== "") {
          html += "<td>" + data.preferredCabin + "</td>";
        } else {
          html += "<td></td>";
        }
        if (data.permittedCarrier !== "") {
          html += "<td>" + data.permittedCarrier + "</td>";
        } else {
          html += "<td></td>";
        }
        if (data.prohibitedCarrier !== "") {
          html += "<td>" + data.prohibitedCarrier + "</td>";
        } else {
          html += "<td></td>";
        }
        html += "</tr>";
        $("#alerts").append(html);
      }
    });
  });


});