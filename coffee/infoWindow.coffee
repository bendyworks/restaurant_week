(($) ->
  handleTabClick = (e) ->
    e.preventDefault()
    $$ = $(@)
    tabContents = $$.parents('.info').find('.tab-content')

    href = $$.attr('href').substring(1)
    tabContents.each (idx, el) ->
      $el = $(el)
      if $el.attr('id') == href
        $el.addClass('open')
      else
        $el.removeClass('open')

    obj.notify('content_changed')

  obj = null

  $.extend $.fn,
    infoWindow: (opts) ->
      $$ = $(@)

      obj = opts.obj
      $$.find('a.tab').on 'click', handleTabClick
      $$.find('.tab-content:first').addClass('open')
      $$

)(Zepto)
