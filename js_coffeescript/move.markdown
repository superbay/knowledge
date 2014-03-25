

```coffeescript
$('#test').is(':visible')
```

### select and move

```coffeescript
  $('#related_items').find('div.related_item').each( (index, element) ->
    if $('.full_width').length
      target_paragraph = $('#article_body').children('p:not(:has(img))').eq(index * interval + 2)
      $(this).insertAfter(target_paragraph)
      $(this).show
    else
      target_paragraph = paragraph(page_index, paragraph_index)
      last_paragraph = $('div.page').eq(page_index).children('p:not(:has(img))').last()
      if target_paragraph.length and not target_paragraph.is(last_paragraph)
        $(this).insertAfter(target_paragraph)
        $(this).show
        paragraph_index += interval
      else if last_paragraph.length
        $(this).insertAfter(last_paragraph)
        $(this).show
        page_index += 1
        paragraph_index = interval - 1
  )

  move_remaining_links_to_end()

move_remaining_links_to_end = () ->
  last_related_link = $('#story_body').find('div.related_item').last()
  $('#related_items').find('div.related_item').each( -> 
    last_related_link.after($(this))
    last_related_link = $(this)
  )

paragraph = (page_index, paragraph_index) ->
  $('div.page').eq(page_index).children('p:not(:has(img))').eq(paragraph_index)
```

[good resource](http://coffeescriptcookbook.com)
