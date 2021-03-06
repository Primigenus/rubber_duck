class window.duck.Renderer
  constructor: (@duck)->
    @container = $ '#duck'
    @question_template = $('#template_question').html()
    @answer_template = $('#template_answer').html()
    @long_template = $('#template_long').html()
    @short_template = $('#template_short').html()
    @reset_template = $('#template_reset').html()
    @choice_template = $('#template_choices').html()
    @duck.on 'response', @response
  response: (event, options)=>
    @strip_current()
    if options.answer_type is 'choice'
      @print_question options.next_question
      @['print_choice'] options.options()
    else
      @print_question options.next_question
      @['print_' + options.answer_type]()
  print_question: (text)=>
    @container.append Mustache.render @question_template, question: text
  print_answer: (text)=>
    @container.append Mustache.render @answer_template, answer: text
  print_long: =>
    @container.append Mustache.render @long_template, {}
    $('#duck .current').focus()
  print_short: =>
    @container.append Mustache.render @short_template, {}
    $('#duck .current').focus()
  print_reset: =>
    @container.append Mustache.render @reset_template, {}
  print_choice: (arr)=>
    @container.append Mustache.render @choice_template, choices: arr
  strip_current: =>
    val = $('#duck .current').val()
    @print_answer val if val
    $('#duck .current, #duck .current_submit, .current_reset').remove()
