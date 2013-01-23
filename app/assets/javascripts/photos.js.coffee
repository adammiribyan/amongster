# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  filterPath = (string) ->
    string
    .replace(/^\//,'')
    .replace(/(index|default).[a-zA-Z]{3,4}$/,'')
    .replace(/\/$/,'')

  scrollableElement = (els) ->
    for el in arguments
      scrollElement = ($ el)

      if scrollElement.scrollTop() > 0 
        return el
      else
        scrollElement.scrollTop(1)
        isScrollable = scrollElement.scrollTop() > 0
        scrollElement.scrollTop(0)

        return el if isScrollable
    []

  locationPath = filterPath(location.pathname)
  scrollElem = scrollableElement('html', 'body')

  ($ 'a[href*=#]').each ->
    thisPath = filterPath(@pathname) || locationPath
    if (locationPath is thisPath) and (location.hostname is @hostname or not @hostname) and (@hash.replace(/#/, ''))
      target = @hash

      if target
        targetOffset = ($ target).offset().top

        ($ this).on 'click', (event) ->
          event.preventDefault()

          ($ scrollElem).animate(
            scrollTop: targetOffset
            400
            -> location.hash = target
          )
