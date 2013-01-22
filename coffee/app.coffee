memoized = (methodBody) ->
  memos = {}
  ->
    key = JSON.stringify(arguments)
    if memos.hasOwnProperty(key)
      memos[key]
    else
      memos[key] = methodBody.apply(this, arguments)

infoWindow = memoized ->
  new google.maps.InfoWindow()

tmpl = memoized ->
  doT.template($('#iconTemplate').html())

map = memoized ->
  center = new google.maps.LatLng 43.0747396, -89.3812588
  mapOptions =
    center: center
    zoom: 12
    mapTypeId: google.maps.MapTypeId.ROADMAP

  new google.maps.Map($("#map_canvas")[0], mapOptions)

clickHandler = (marker, rest) ->
  (event) ->
    do (info = infoWindow()) ->
      template = $.trim tmpl()(rest)
      content = $(template).infoWindow({obj: info})[0]

      info.setContent(content)

      listener = info.addListener 'domready', ->
        $('.info').infoWindow
          obj: info
        google.maps.event.removeListener listener

      info.open(map(), marker)

tapHandler = (marker, rest) ->
  (event) ->
    console.log('handle tap')
    do (overlay = $('#mobile_overlay')) ->

      $template = $(tmpl()(rest))
      overlay.find('.content').html($template)
      $template.infoWindow()

      overlay.find('a.close').on 'click', (e) ->
        e.preventDefault()
        overlay.hide()

      overlay.show()

hasLunch = (data) ->
  $.grep(data.meals, (meal) -> meal.type == 'lunch').length > 0

$ ->

  for rest in restaurants
    do (rest) ->
      data = rest['data']
      marker = if hasLunch(data)
        shadow =
          url: 'https://www.google.com/mapfiles/shadow50.png'
          size: new google.maps.Size(59,32)
          origin: new google.maps.Point(0,0)
          anchor: new google.maps.Point(12,32)

        pin =
          url: 'https://www.google.com/intl/en_us/mapfiles/ms/micons/yellow-dot.png',
          size: new google.maps.Size(32,32)
          origin: new google.maps.Point(0,0)
          anchor: new google.maps.Point(16,32)

        new google.maps.Marker
          position: new google.maps.LatLng(data.lat, data.lng)
          map: map()
          title: data.name
          icon: pin
          shadow: shadow
      else
        new google.maps.Marker
          position: new google.maps.LatLng(data.lat, data.lng)
          map: map()
          title: data.name

      handler = if $(window).width() <= 568 then tapHandler else clickHandler
      google.maps.event.addListener marker, 'click', handler(marker, rest)
