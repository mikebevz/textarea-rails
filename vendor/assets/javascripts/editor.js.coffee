jQuery.noConflict
jQuery ->
  textarea = new Control.TextArea("markdown_example")
  toolbar = new Control.TextArea.ToolBar(textarea)
  toolbar.container.id = "markdown_toolbar" #for css styles

  #preview of markdown text  
  converter = new Showdown.converter()
  converter_callback = (value) =>
    console.log value
    $("markdown_formatted").update converter.makeHtml(value)
    
  
  console.log converter.makeHtml("sdfsdf")
  #converter_callback(textarea.getValue())
  textarea.observe "change", converter_callback

  #buttons  
  toolbar.addButton "Italics", (->
    @wrapSelection "*", "*"
  ),
    id: "markdown_italics_button"

  toolbar.addButton "Bold", (->
    @wrapSelection "**", "**"
  ),
    id: "markdown_bold_button"

  toolbar.addButton "Link", (->
    selection = @getSelection()
    response = prompt("Enter Link URL", "")
    return  unless response?
    @replaceSelection "[" + ((if selection is "" then "Link Text" else selection)) + "](" + ((if response is "" then "http://link_url/" else response)).replace(/^(?!(f|ht)tps?:\/\/)/, "http://") + ")"
  ),
    id: "markdown_link_button"

  toolbar.addButton "Image", (->
    selection = @getSelection()
    response = prompt("Enter Image URL", "")
    return  unless response?
    @replaceSelection "![" + ((if selection is "" then "Image Alt Text" else selection)) + "](" + ((if response is "" then "http://image_url/" else response)).replace(/^(?!(f|ht)tps?:\/\/)/, "http://") + ")"
  ),
    id: "markdown_image_button"

  toolbar.addButton "Heading", (->
    selection = @getSelection()
    selection = "Heading"  if selection is ""
    @replaceSelection "\n" + selection + "\n" + $R(0, Math.max(5, selection.length)).collect(->
      "-"
    ).join("") + "\n"
  ),
    id: "markdown_heading_button"

  toolbar.addButton "Unordered List", ((event) ->
    @collectFromEachSelectedLine (line) ->
      (if event.shiftKey then ((if line.match(/^\*{2,}/) then line.replace(/^\*/, "") else line.replace(/^\*\s/, ""))) else ((if line.match(/\*+\s/) then "*" else "* ")) + line)

  ),
    id: "markdown_unordered_list_button"

  toolbar.addButton "Ordered List", ((event) ->
    i = 0
    @collectFromEachSelectedLine (line) ->
      unless line.match(/^\s+$/)
        ++i
        (if event.shiftKey then line.replace(/^\d+\.\s/, "") else ((if line.match(/\d+\.\s/) then "" else i + ". ")) + line)

  ),
    id: "markdown_ordered_list_button"

  toolbar.addButton "Block Quote", ((event) ->
    @collectFromEachSelectedLine (line) ->
      (if event.shiftKey then line.replace(/^\> /, "") else "> " + line)

  ),
    id: "markdown_quote_button"

  toolbar.addButton "Code Block", ((event) ->
    @collectFromEachSelectedLine (line) ->
      (if event.shiftKey then line.replace(RegExp("    "), "") else "    " + line)

  ),
    id: "markdown_code_button"

  toolbar.addButton "Help", (->
    window.open "http://daringfireball.net/projects/markdown/dingus"
  ),
    id: "markdown_help_button"
  
    
