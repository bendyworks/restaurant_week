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
      template = tmpl()(rest)
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
      markerOpts = if hasLunch(data)
        icon: 'https://www.google.com/intl/en_us/mapfiles/ms/micons/yellow-dot.png'
        shadow: 'https://www.google.com/mapfiles/shadow50.png'
      else
        {}
      markerOpts.position = new google.maps.LatLng(data.lat, data.lng)
      markerOpts.map = map()
      markerOpts.title = data.name
      marker = new google.maps.Marker markerOpts

      handler = if $(window).width() <= 568 then tapHandler else clickHandler
      google.maps.event.addListener marker, 'click', handler(marker, rest)
