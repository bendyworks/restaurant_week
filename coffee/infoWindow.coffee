(($) ->
  handleTabClick = (e) ->
    e.preventDefault()
    activateTab($(@))

  activateTab = ($tab) ->
    $parentLi = $tab.parent()
    $parentLi.addClass('active')
    $parentLi.parent().find('> li').not($parentLi).removeClass('active')

    tabContents = $tab.parents('.info').find('.tab-content')

    href = $tab.attr('href').substring(1)
    tabContents.each (idx, el) ->
      $el = $(el)
      if $el.attr('id') == href
        $el.addClass('open')
      else
        $el.removeClass('open')

    obj?.notify('content_changed')

  obj = null

  $.extend $.fn,
    infoWindow: (opts = {}) ->
      $$ = $(@)

      obj = opts.obj
      $$.find('a.tab').on 'click', handleTabClick
      activateTab($$.find('a.tab:first'))
      $$.parent().css('overflow-y', 'scroll')
      $$

)(jQuery)
