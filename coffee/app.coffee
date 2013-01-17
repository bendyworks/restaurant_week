$ ->
  infoWindowTemplate = doT.template($('#iconTemplate').html())

  center = new google.maps.LatLng 43.0747396, -89.3812588
  mapOptions =
    center: center
    zoom: 12
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map($("#map_canvas")[0], mapOptions)

  infoWindow = new google.maps.InfoWindow()

  for rest in restaurants
    do (rest) ->
      data = rest['data']
      marker = new google.maps.Marker
        position: new google.maps.LatLng(data.lat, data.lng)
        map: map
        title: data.name

      google.maps.event.addListener marker, 'click', (event) ->
        content = infoWindowTemplate(rest)
        infoWindow.setContent(content)
        infoWindow.open(map, marker)
        $('.info').infoWindow
          obj: infoWindow
