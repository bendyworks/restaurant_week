(($) ->
  obj = null

  $.extend $.fn,
    infoWindow: (opts = {}) ->
      $$ = $(@)

      obj = opts.obj
      $$.parent().css('overflow-y', 'scroll')
      $$

)(jQuery)
